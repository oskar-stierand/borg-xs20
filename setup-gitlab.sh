#!/bin/bash
# setup-gitlab.sh
# Inicializuje Git repo a pushne na GitLab.
# Spusť jednou po vytvoření projektu na GitLabu.
#
# Použití:
#   chmod +x setup-gitlab.sh
#   ./setup-gitlab.sh https://gitlab.com/TVUJ_USERNAME/borg-xs20.git

set -e

REMOTE_URL="${1}"

if [ -z "$REMOTE_URL" ]; then
  echo "❌ Chybí URL GitLab repozitáře."
  echo "   Použití: ./setup-gitlab.sh https://gitlab.com/USERNAME/borg-xs20.git"
  exit 1
fi

echo "🎛️  BORG XS-20 — GitLab setup"
echo "================================"

# Init
if [ ! -d ".git" ]; then
  git init
  echo "✅ Git inicializován"
else
  echo "ℹ️  Git repo již existuje"
fi

# Remote
if git remote get-url origin &>/dev/null; then
  echo "ℹ️  Remote 'origin' již nastaven: $(git remote get-url origin)"
else
  git remote add origin "$REMOTE_URL"
  echo "✅ Remote přidán: $REMOTE_URL"
fi

# První commit
git add .
git commit -m "feat: initial commit — BORG XS-20 v4.1-bugfix

Webový syntezátor inspirovaný Korg MS-20.
- Analogový audio engine (Steiner-Parker, saturace, VCO drift)
- 8-hlasá parafonie se stealingem
- MIDI podpora (Note On/Off, Pitch Bend, CC)
- 8 factory presetů
- Computer keyboard ovládání
- Dřevěné boky, Pitch/Mod kola" 2>/dev/null || echo "ℹ️  Nic nového k commitnutí"

# Push
git branch -M main
git push -u origin main

echo ""
echo "🎉 Hotovo! Repo je na GitLabu:"
echo "   $REMOTE_URL"
echo ""
echo "Další kroky:"
echo "  1. Otevři GitLab a zkontroluj že vše dorazilo"
echo "  2. Nastav GitLab Pages pokud chceš syntetizátor hostovat online"
echo "  3. Přidej Linear → GitLab integraci pro automatické linky na issues"
