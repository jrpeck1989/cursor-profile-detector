#!/bin/zsh
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
BIN="$HOME/bin"
APPS="$HOME/Applications"
PROFILE_BASE="$HOME/Library/Application Support/CursorProfiles"

mkdir -p "$BIN" "$APPS" "$PROFILE_BASE/personal/extensions" "$PROFILE_BASE/work/extensions"

install -m 0755 "$PROJECT_DIR/scripts/cursor-smart" "$BIN/cursor-smart"
install -m 0755 "$PROJECT_DIR/scripts/cursor-personal" "$BIN/cursor-personal"
install -m 0755 "$PROJECT_DIR/scripts/cursor-work" "$BIN/cursor-work"
install -m 0755 "$PROJECT_DIR/scripts/cursor-oss" "$BIN/cursor-oss"
install -m 0755 "$PROJECT_DIR/scripts/cursor-sync-extensions" "$BIN/cursor-sync-extensions"

osacompile -o "$APPS/Cursor Smart.app" "$PROJECT_DIR/applescripts/Cursor Smart.applescript" | cat
osacompile -o "$APPS/Cursor Personal.app" "$PROJECT_DIR/applescripts/Cursor Personal.applescript" | cat
osacompile -o "$APPS/Cursor Work.app" "$PROJECT_DIR/applescripts/Cursor Work.applescript" | cat

RC_FILE="$HOME/.zshrc"
if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$RC_FILE" 2>/dev/null; then
  printf '\n# Cursor smart launchers\nexport PATH="$HOME/bin:$PATH"\n' >> "$RC_FILE"
fi

echo "Installed scripts to: $BIN"
echo "Installed apps to:    $APPS"
echo "Profiles at:          $PROFILE_BASE/{personal,work}"

echo "Test with:"
echo "  $BIN/cursor-smart --dry-run \"$HOME/Documents/work-projects/_profile-test\""
echo "  $BIN/cursor-smart --dry-run \"$HOME/Documents/personal-projects/_profile-test\""


