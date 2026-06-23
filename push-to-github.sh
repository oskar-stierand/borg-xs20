#!/bin/bash
# push-to-github.sh
# Vytvoří GitHub repo a pushne BORG XS-20
# Předpoklad: gh CLI je přihlášený (gh auth status)

set -e

REPO_NAME="borg-xs20"
DESCRIPTION="Webový syntezátor inspirovaný Korg MS-20 — Web Audio API, MIDI, single-file HTML"

echo "🎛️  BORG XS-20 — GitHub push"
echo "=============================="

# Vytvoř repo na GitHubu (public, bez init)
gh repo create "$REPO_NAME" \
  --public \
  --description "$DESCRIPTION" \
  --confirm 2>/dev/null || echo "ℹ️  Repo možná už existuje, pokračuji..."

# Git init (pokud ještě není)
if [ ! -d ".git" ]; then
  git init
  git branch -M main
fi

# Remote
GITHUB_USER=$(gh api user --jq '.login')
REMOTE_URL="https://github.com/${GITHUB_USER}/${REPO_NAME}.git"

if git remote get-url origin &>/dev/null; then
  echo "ℹ️  Remote origin: $(git remote get-url origin)"
else
  git remote add origin "$REMOTE_URL"
  echo "✅ Remote: $REMOTE_URL"
fi

# Commit a push
git add .
git commit -m "feat: initial commit — BORG XS-20 v4.1-bugfix

Webový syntezátor inspirovaný Korg MS-20.
- Analogový audio engine (Steiner-Parker filtr, 3× saturace, VCO drift)
- 8-hlasá parafonie se stealingem
- MIDI podpora (Note On/Off, Pitch Bend, CC, hot-plug)
- 8 factory presetů (Robert Miles, Jean-Michel Jarre)
- Computer keyboard ovládání
- Dřevěné boky, Pitch/Mod kola
- Bugfix: MIDI vizuální efekt + oktáva klaviatury" 2>/dev/null || echo "ℹ️  Nic nového ke commitu"

git push -u origin main

echo ""
echo "🎉 Hotovo!"
echo "   https://github.com/${GITHUB_USER}/${REPO_NAME}"
