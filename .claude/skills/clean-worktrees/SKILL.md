---
name: clean-worktrees
description: List, audit, and remove Claude Code worktrees for this repo
---

# Clean Worktrees

Audit all git worktrees under `.claude/worktrees/` and help remove the ones no longer needed.

## Steps

1. **List all worktrees** with their branch and any uncommitted changes:
   ```bash
   MAIN=$(git rev-parse --show-toplevel 2>/dev/null || git -C . rev-parse --show-toplevel)
   git -C "$MAIN" worktree list
   ```

2. **Check each worktree for uncommitted changes** — warn the user before removing any that have them:
   ```bash
   git -C <worktree-path> status --short
   ```

3. **For each worktree the user confirms removing:**
   - Remove the worktree directory and deregister it from git:
     ```bash
     git -C "$MAIN" worktree remove <worktree-path>
     ```
   - Delete the corresponding local branch (named `worktree/<name>`):
     ```bash
     git -C "$MAIN" branch -d worktree/<name>
     ```
   - If the worktree has uncommitted changes and the user still wants to remove it, use `--force` and confirm explicitly before proceeding.

4. **Prune any stale worktree metadata** (entries whose directories no longer exist):
   ```bash
   git -C "$MAIN" worktree prune
   ```

5. **Report the final worktree list** after cleanup.

## Notes

- The main repo worktree (`[main]`) is never a removal candidate — skip it.
- Always show a summary of what will be deleted and ask for confirmation before removing anything.
- If a branch has already been merged to `main`, note that so the user knows it's safe to delete.
