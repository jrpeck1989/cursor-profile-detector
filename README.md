# Cursor Profile Detector Setup

This repo installs a smart Cursor launcher that picks the correct profile based on the project path and provides macOS app launchers and an Alfred script.

## Install

```bash
./install.sh
```

- Scripts install to `~/bin`
- Apps compile to `~/Applications`
- Profiles live at `~/Library/Application Support/CursorProfiles/{personal,work}`

## Usage

- Auto-detect by folder:
  - `cursor-smart /path/to/project`
  - `cursor-smart --wait /path/to/project` (waits for Cursor to close)
- Force:
  - `cursor-work /path/to/project`
  - `cursor-personal /path/to/project`
  - `cursor-work --wait /path/to/project` (waits for Cursor to close)
- Extensions sync:
  - Dry run: `cursor-sync-extensions --dry-run --from ~/.vscode/extensions --to both`
  - Run: `cursor-sync-extensions --from ~/.vscode/extensions --to both`

### Git Integration

Use the `--wait` flag for git workflows:

```bash
# Set as git editor for commit messages
git config --global core.editor "cursor-smart --wait"

# Use in git rebase
git config --global sequence.editor "cursor-smart --wait"

# Use for specific git operations
git commit --edit # will wait for Cursor to close
```

## Alfred

Use `alfred/cursorf.applescript` in a "Run NSAppleScript" action for your `cursorf` keyword.
It calls `~/bin/cursor-smart` directly and supports Finder selection when no argument is supplied.

## Notes

- Work projects are detected by `~/Documents/work-projects`. All others map to the personal profile.
- This follows the per-project account routing pattern suggested here: [Cursor forum thread](https://forum.cursor.com/t/multi-account-support-with-project-level-assignment/102865/4).
