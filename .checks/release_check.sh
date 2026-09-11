#!/usr/bin/env bash
# Pre-release checks for the Cherry-PIC repository.
#
#   bash .checks/release_check.sh
#
# Every check here exists because something slipped past a human read. Run it before
# any release, before making the repository public, and after editing documentation.
# Exit status is the number of failures.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
FAIL=0
pass(){ printf "  \033[32mPASS\033[0m  %s\n" "$1"; }
fail(){ printf "  \033[31mFAIL\033[0m  %s\n" "$1"; FAIL=$((FAIL+1)); }
warn(){ printf "  \033[33mWARN\033[0m  %s\n" "$1"; }
head(){ printf "\n\033[1m%s\033[0m\n" "$1"; }

head "1. Credentials and secrets"
HITS=$(git ls-files -z | xargs -0 grep -lE "(PASSWORD|PASSWD|SECRET|API_KEY|_TOKEN)[ ]*=|BEGIN (RSA|OPENSSH) PRIVATE" 2>/dev/null | grep -v "^.checks/" || true)
[ -z "$HITS" ] && pass "no credential patterns in tracked files" \
                || fail "credential pattern found in: $HITS"

head "2. File sizes (GitHub rejects >100 MB, warns >50 MB)"
BIG=$(git ls-files -z | tr '\0' '\n' | while IFS= read -r f; do
        [ -f "$f" ] && s=$(wc -c <"$f") && [ "$s" -gt 10485760 ] && echo "$f"; done)
[ -z "$BIG" ] && pass "no tracked file over 10 MB" || fail "oversized tracked files: $BIG"

head "3. Documentation paths resolve"
MISS=0
for md in $(git ls-files '*.md'); do
  grep -oE '`[^`]{6,140}\.(Rmd|R|py|csv|xlsx|rds|RDS|tsv|sh)`' "$md" 2>/dev/null |
  tr -d '`' | while read -r t; do
    case "$t" in /*|http*|*" "*) continue;; esac
    case "$t" in */*) ;; *) continue;; esac
    [ -n "$(find . -path "*$t" -not -path './.git/*' 2>/dev/null | head -1)" ] ||
      echo "    $md -> $t"
  done
done > /tmp/_relcheck_paths.$$ 2>/dev/null
MISS=$(wc -l < /tmp/_relcheck_paths.$$ | tr -d ' ')
[ "$MISS" = "0" ] && pass "every path referenced in documentation exists" \
                  || { fail "$MISS documentation path(s) do not resolve"; cat /tmp/_relcheck_paths.$$; }
rm -f /tmp/_relcheck_paths.$$

head "3b. Sandbox and site paths in tracked code"
# /mnt/user-uploads and /mnt/results are the analysis sandbox's paths; they resolve
# nowhere else. Documentation may mention them when describing what a delivery contained.
SBX=0
while IFS= read -r f; do
  echo "    $f"; SBX=$((SBX+1))
# earlier-per-region-qc/ is kept as the record of a superseded processing pass; its paths
# are part of that record and are documented as unreachable.
done < <(git grep -lE "/mnt/(user-uploads|results)|/sc/arion|/gpfs/|/hpc/packages" -- '*.R' '*.Rmd' '*.py' ':!**/Full-data/**' ':!**/earlier-per-region-qc/**' 2>/dev/null)
[ "$SBX" = "0" ] && pass "no sandbox or site paths in tracked code" \
                 || fail "$SBX tracked script(s) carry a path that resolves only on another system"

head "4. Stale status language in documentation"
STALE=$(grep -rniE "still missing|not yet (fixed|rendered|deposited)|blocked on|TODO|FIXME|decide whether|version of record|does not reproduce" \
        $(git ls-files '*.md') 2>/dev/null | grep -v "^.checks/" || true)
[ -z "$STALE" ] && pass "no unreviewed status language" \
                || { warn "review these — they may describe resolved issues:"; echo "$STALE" | cut -c1-120 | sed 's/^/    /'; }

head "5. .R twins are current"
# Content check: regenerate each twin to a temporary file and diff it. An mtime test
# misses child-notebook edits, which leave the twin newer than its parent — and purl()
# will not overwrite a newer twin, so an in-place regeneration silently does nothing.
DRIFT=0
if command -v Rscript >/dev/null 2>&1 && Rscript -e 'quit(status = !requireNamespace("knitr", quietly = TRUE))' >/dev/null 2>&1; then
  while IFS= read -r rmd; do
    r="${rmd%.Rmd}.R"
    [ -f "$r" ] || continue
    t=$(mktemp)
    ( cd "$(dirname "$rmd")" && Rscript -e "knitr::purl('$(basename "$rmd")', output='$t', quiet=TRUE, documentation=1)" >/dev/null 2>&1 )
    if [ ! -s "$t" ]; then echo "    could not purl: $rmd"; DRIFT=$((DRIFT+1))
    elif ! diff -q "$t" "$r" >/dev/null; then echo "    stale: $r"; DRIFT=$((DRIFT+1)); fi
    rm -f "$t"
  done < <(git ls-files '*.Rmd')
  [ "$DRIFT" = "0" ] && pass "every .R twin matches a fresh knitr::purl() of its notebook" \
                     || fail "$DRIFT twin(s) differ from their notebook — regenerate (README, Running the code)"
else
  while IFS= read -r rmd; do
    r="${rmd%.Rmd}.R"
    [ -f "$r" ] || continue
    [ "$rmd" -nt "$r" ] && { echo "    stale: $r"; DRIFT=$((DRIFT+1)); }
  done < <(git ls-files '*.Rmd')
  [ "$DRIFT" = "0" ] && pass "every .R twin is at least as new as its .Rmd (mtime only — Rscript or knitr not found)" \
                     || fail "$DRIFT twin(s) older than their source — regenerate with knitr::purl()"
fi

head "6. Declared dependencies match the code"
CALLED=$(grep -rhoE "library\([A-Za-z0-9.]+\)" $(git ls-files '*.Rmd' '*.R') 2>/dev/null |
         sed 's/library(//;s/)//' | sort -u)
UNDOC=""
for p in $CALLED; do
  grep -q "\b$p\b" README.md 2>/dev/null || UNDOC="$UNDOC $p"
done
[ -z "$UNDOC" ] && pass "every library() call appears in README.md" \
                || fail "called but undocumented:$UNDOC"

head "7. Determinism"
UNSEEDED=$(grep -rln "RunHarmony" $(git ls-files '*.Rmd' '*.R') 2>/dev/null | while read -r f; do
             grep -q "set.seed" "$f" || echo "    $f"; done)
[ -z "$UNSEEDED" ] && pass "every RunHarmony call site sets a seed" \
                   || { warn "RunHarmony without set.seed (deposited object is the version of record):"; echo "$UNSEEDED"; }

head "8. Figure index covers every produced panel"
IDX=$(grep -coE '^\| \*\*(3|4|6|S[0-9])[A-Z]?' README.md 2>/dev/null || echo 0)
[ "$IDX" -ge 25 ] && pass "figure index lists $IDX panels" \
                  || fail "figure index lists only $IDX panels — expected 28"

printf "\n"
[ "$FAIL" = "0" ] && printf "\033[32mAll checks passed.\033[0m\n" \
                  || printf "\033[31m%s check(s) failed.\033[0m\n" "$FAIL"
exit "$FAIL"
