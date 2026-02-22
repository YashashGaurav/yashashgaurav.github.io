# Architecture Spec

## Tech Stack
Hugo (extended) + PaperModX | GitHub Pages | Custom CSS (`assets/css/extended/`) | Playwright (E2E, planned)

## Site Structure
```
Landing ─┬─ About ─── CV / Resume (PDF viewer)
         ├─ Photography ─→ Adobe Portfolio (redirect)
         ├─ Posts ──── [filters] → Post cards → Post detail (tags)
         └─ Projects ── Gallery grid → Project page or Post
```

## Theme Customization
Extend PaperModX through `layouts/` overrides and `assets/css/extended/`. Never modify files inside `themes/PaperModX/` directly.

## Current Paths (exist)
```
layouts/partials/header.html      # Nav override with theme toggle
layouts/shortcodes/note.html      # Callout box shortcode
assets/css/extended/custom.css    # Link colors, note box, profile buttons, typography
static/images/mymemoji_withbg.png # Profile and OG image
content/posts/                    # 4 published blog posts
```

## Planned Paths
```
content/about.md                  # About page with CV/Resume links
content/photography/_index.md     # Photography section (redirects to Adobe Portfolio)
content/projects/                 # Project pages
data/experience.yaml              # CV timeline data
layouts/partials/cv.html          # Two-column CV component
layouts/shortcodes/gallery.html   # Tiled project gallery
assets/css/extended/cv-layout.css # CV-specific styles
tests/navigation.spec.ts          # Playwright E2E tests
```

## Data Schema

**`data/experience.yaml`:**
```yaml
- id: ripple
  company: Ripple Labs
  role: Applied Scientist
  dates: Feb 2023 – Present
  location: San Francisco, CA
  summary: LLM systems, retrieval, evaluation
  details: |
    Markdown content...
```

## Workflow
1. Local dev: `hugo server -D`
2. Run `/update-progress` after completing features
3. Push to `main` → auto-deploy via GitHub Actions
