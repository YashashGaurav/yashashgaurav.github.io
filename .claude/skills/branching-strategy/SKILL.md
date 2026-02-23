---
name: branching-strategy
description: Apply the correct branching workflow for this repository
---

# Branching Strategy

## Core Rules

- **Never commit directly to `main`.** Always create a feature branch, no matter how small the change.
- `main` is the production branch — pushing to `main` triggers auto-deploy to GitHub Pages via `.github/workflows/hugo.yaml`.
- All changes must go through a PR targeting `main`.
- CI runs build checks on PRs to `main` via `.github/workflows/ci.yml`.

## Branch Naming

Use the `<initials>/<description>` convention:

```
yg/add-cv-layout
yg/fix-mobile-nav
yg/chore-update-deps
```

- Initials: `yg` (Yashash Gaurav)
- Description: lowercase kebab-case
- Examples: `yg/add-projects-section`, `yg/fix-footer-links`

## Merge Policy

- **Squash merge only.** Merge commits and rebase merges are disabled on GitHub.
- **Branch auto-deleted on merge.** GitHub deletes the remote head branch automatically after a PR is merged.
- After merging, clean up the local branch manually:
  ```bash
  git checkout main && git pull
  git branch -d yg/<description>
  ```

## Workflow

1. Create a feature branch from `main`:
   ```bash
   git checkout main && git pull
   git checkout -b yg/<description>
   ```
2. Make commits using semantic prefixes (`feat:`, `fix:`, `chore:`, `docs:`, etc.)
3. Push branch and open a PR targeting `main`
4. CI checks must pass before merge
5. Squash merge the PR — GitHub auto-deletes the remote branch
6. Clean up local branch (see Merge Policy above)
7. Merge to `main` triggers GitHub Pages deployment

## Commit Prefixes

| Prefix | Use |
|--------|-----|
| `feat:` | New feature or content |
| `fix:` | Bug fix |
| `chore:` | Maintenance, config, deps |
| `docs:` | Documentation only |
| `style:` | CSS/layout changes |
| `refactor:` | Code restructure, no behavior change |
