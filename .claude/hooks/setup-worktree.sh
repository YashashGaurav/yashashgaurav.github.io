#!/bin/bash
# WorktreeCreate hook for Claude Code.
# Replaces the default git worktree creation so we can symlink untracked
# essential files (settings.local.json, .env, etc.) into every new worktree.
#
# Protocol:
#   stdin  — JSON with at least {"name": "<worktree-name>"}
#   stdout — absolute path of the new worktree (Claude Code reads this)
#   stderr — diagnostic messages

set -euo pipefail

INPUT=$(cat)
NAME=$(echo "$INPUT" | jq -r '.name')
# --git-common-dir always points at the *main* repo's .git, even when run
# from inside a worktree (where --show-toplevel would return the worktree root).
REPO_ROOT=$(cd "$(git rev-parse --git-common-dir)/.." && pwd)
WORKTREE_DIR="$REPO_ROOT/.claude/worktrees/$NAME"

# Step 1: Create the git worktree
git worktree add "$WORKTREE_DIR" -b "worktree/$NAME" HEAD >&2

# Step 2: Initialize submodules (worktrees don't inherit them)
git -C "$WORKTREE_DIR" submodule update --init --recursive >&2

# Step 3: Symlink untracked essential files
FILES_TO_SYMLINK=(
  ".claude/settings.local.json"
  ".env"
  ".env.local"
  ".envrc"
)

for FILE in "${FILES_TO_SYMLINK[@]}"; do
  SOURCE="$REPO_ROOT/$FILE"
  TARGET="$WORKTREE_DIR/$FILE"
  if [ -f "$SOURCE" ]; then
    mkdir -p "$(dirname "$TARGET")"
    rm -f "$TARGET"          # remove any copy from checkout
    ln -s "$SOURCE" "$TARGET"
    echo "Symlinked $FILE" >&2
  fi
done

# Step 4: Output the worktree path (required by Claude Code)
echo "$WORKTREE_DIR"
