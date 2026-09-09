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

head "4. Stale status language in documentation"
STALE=$(grep -rniE "still missing|not yet (fixed|rendered|deposited)|blocked on|TODO|FIXME|decide whether|version of record|does not reproduce" \
        $(git ls-files '*.md') 2>/dev/null | grep -v "^.checks/" || true)
[ -z "$STALE" ] && pass "no unreviewed status language" \
                || { warn "review these — they may describe resolved issues:"; echo "$STALE" | cut -c1-120 | sed 's/^/    /'; }

head "5. .R twins are current"
DRIFT=0
for rmd in $(git ls-files '*_final.Rmd'); do
  r="${rmd%.Rmd}.R"
  [ -f "$r" ] || continue
  [ "$rmd" -nt "$r" ] && { echo "    stale: $r"; DRIFT=$((DRIFT+1)); }
done
[ "$DRIFT" = "0" ] && pass "every .R twin is at least as new as its .Rmd" \
                   || fail "$DRIFT twin(s) older than their source — regenerate with knitr::purl()"

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
