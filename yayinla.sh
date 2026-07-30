#!/usr/bin/env bash
# FişTakip — tek tıkla GitHub'a yayınla
set -uo pipefail
cd "$(dirname "$0")"

REPO="https://github.com/kamilsaim/fistakip.git"
BRANCH="main"

b=$'\e[1m'; d=$'\e[2m'; r=$'\e[31m'; g=$'\e[32m'; n=$'\e[0m'
say(){ printf '  %s\n' "$*"; }
die(){ printf '  %s%s%s\n\n' "$r" "$*" "$n"; read -rp "  Kapatmak için Enter..."; exit 1; }

printf '\n  %s════════════════════════════════════%s\n' "$b" "$n"
printf '  %sFişTakip · GitHub'"'"'a yayınla%s\n' "$b" "$n"
printf '  %s════════════════════════════════════%s\n\n' "$b" "$n"

command -v git >/dev/null || die "Git kurulu değil."
[ -f index.html ] || die "index.html bulunamadı. Betiği proje klasörüne koy."

VER=$(sed -n "s/.*version:'\([^']*\)'.*/\1/p" index.html | head -1)
VER=${VER:-0.0.0}
say "Sürüm: ${b}v$VER${n}"

# ── ilk çalıştırma: depoyu bağla ──
if [ ! -d .git ]; then
  say "Depo bağlanıyor..."
  git init -q
  git remote add origin "$REPO"
  if git fetch -q origin "$BRANCH" 2>/dev/null; then
    git reset -q --soft FETCH_HEAD   # uzaktaki geçmişi devral, dosyalara dokunma
  fi
  git branch -q -M "$BRANCH"
else
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "$REPO"
fi

# ── değişiklik var mı ──
git add -A
if git diff --cached --quiet; then
  say "${d}Değişiklik yok.${n}"
  printf '\n'; read -rp "  Kapatmak için Enter..."; exit 0
fi

printf '\n  %sGönderilecek:%s\n' "$b" "$n"
git diff --cached --name-status | sed 's/^/    /'
printf '\n'

read -rp "  Açıklama (boş bırak = \"v$VER\"): " MSG
MSG=${MSG:-v$VER}

git commit -q -m "$MSG" || die "Commit başarısız."

say "Gönderiliyor..."
if ! git push -u origin "$BRANCH"; then
  printf '\n  %sPush başarısız.%s\n' "$r" "$n"
  say "Kimlik doğrulama isterse şifre yerine Personal Access Token gir:"
  say "${d}https://github.com/settings/tokens${n}"
  printf '\n'; read -rp "  Kapatmak için Enter..."; exit 1
fi

# ── sürüm etiketi ──
if ! git rev-parse "v$VER" >/dev/null 2>&1; then
  git tag -a "v$VER" -m "v$VER"
  git push -q origin "v$VER" 2>/dev/null && say "${g}Etiket: v$VER${n}"
fi

printf '\n  %s════════════════════════════════════%s\n' "$g" "$n"
say "${g}Tamam.${n} https://kamilsaim.github.io/fistakip/"
printf '  %s════════════════════════════════════%s\n\n' "$g" "$n"
say "${d}Pages'in güncellenmesi 1-2 dakika sürebilir.${n}"
printf '\n'
read -rp "  Kapatmak için Enter..."
