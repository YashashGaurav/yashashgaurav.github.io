# Project Spec: YashashGaurav.com

**Goal:** Migrate Notion site → Hugo on GitHub Pages. Redirect domain after v1 completion.

## Milestones

### ✅ M0: Foundation
- [x] Hugo + PaperModX theme (git submodule)
- [x] GitHub Actions deploy pipeline → GitHub Pages
- [x] Favicons, profile image (`static/images/mymemoji_withbg.png`)
- [x] Base custom CSS (`assets/css/extended/custom.css`)
- [x] Syntax highlighting, Fuse.js search configured

### ✅ MVP: Landing Page
- [x] Profile mode landing (image, title, subtitle)
- [x] Social links: GitHub, LinkedIn, X
- [x] Nav menu: home, about, photography, posts, projects
- [x] Profile buttons: photography, posts, posts
- [x] 4 initial blog posts published
- [x] About page (`content/about.md`) with placeholder CV/Resume links
- [x] Photography section → redirect to Adobe Portfolio
- [x] `content/photography/` and `content/projects/` sections exist so profile buttons don't 404

### 🚧 v1: CV Page
- [ ] `data/experience.yaml` populated (Ripple, CMU, FA1, NIT Silchar)
- [ ] `layouts/partials/cv.html` — two-column: timeline (left) + accordion details (right)
- [ ] `assets/css/extended/cv-layout.css` — CV-specific styles
- [ ] TOC for jumping between roles
- [ ] Resume PDF embedded via Google Viewer (no download)
- [ ] About page updated to link to CV page

### 📋 v2: Posts
- [ ] Posts list page with category filter buttons
- [ ] Post cards: hero image, title, summary
- [ ] Individual post layout: full markdown, tags, original publish dates
- [ ] Migrate remaining content from Notion

### 📋 v3: Projects
- [ ] `content/projects/` section with project pages
- [ ] `layouts/shortcodes/gallery.html` — tiled grid of project hero images
- [ ] Links from project tiles to project pages or related posts
- [ ] Migrate from Notion
