---
name: migrate-notion-project
description: Migrate a project page from Notion to the Hugo portfolio
---

# Migrate Notion Project

## Before You Start

Gather the following from the Notion page and the project's GitHub repo (README, commit history):

| Field | Source | Notes |
|-------|--------|-------|
| Title | Notion page title | Title-cased |
| Date | Last substantive GitHub commit | Format: `YYYY-MM-DD` |
| Tags | Tech stack from Notion / README | Title-cased, e.g. `"Python"`, `"BeautifulSoup"` |
| Summary | One-line description | Used on list/card pages |
| Context | Notion page or project origin | `"personal"` or `"college"` |
| Status | Completion state | `"completed"` (only value used so far) |
| projectURL | GitHub repo URL | Required |
| demoURL | YouTube or live demo link | Optional |
| Team | Collaborators + LinkedIn URLs | College projects only |

---

## Frontmatter Template

```yaml
---
title: "Project Name"
date: YYYY-MM-DD
draft: false
tags: ["Tech1", "Tech2", "Tech3"]
summary: "One-sentence description — context phrase (e.g. a CMU Deep Learning project)"
showToc: true
params:
  context: "personal"          # "personal" | "college"
  projectURL: "https://github.com/YashashGaurav/RepoName"
  status: "completed"
  demoURL: "https://www.youtube.com/watch?v=VIDEO_ID"   # omit if no demo
---
```

**Field notes:**
- `context` drives the badge colour via `project-context--{value}` CSS class. Currently supported: `personal`, `college`. If adding a new value, add the CSS class in `assets/css/extended/custom.css`.
- `demoURL` is optional. Omit the line entirely if there is no demo.
- `showToc` is always `true` for project pages.
- `draft` is always `false` for published content.

---

## Body Structure

### Pattern A — Video-first (college projects with a YouTube demo)

Use this when the project has a demo video. Poet AI and College Helper follow this pattern.

```markdown
{{< youtube VIDEO_ID >}}
</br>

Above is the fastest way to know what my team did 😃

## The Why

[One or two paragraphs explaining the problem and motivation.]

## The What

[Project name] [does X]. Key features:

- **Feature Label** — Description of what it does
- **Feature Label** — Description of what it does
- **Feature Label** — Description of what it does

## Team

Built by [Name](LinkedIn URL), [Name](LinkedIn URL), and [Yashash Gaurav](https://github.com/YashashGaurav) (Me) — [course name or project context].
```

### Pattern B — Narrative writeup (personal projects, no video)

Use this when the project has no demo video. Global Entry Scraper follows this pattern.

```markdown
# [Restate the core idea as a heading]

[Intro paragraph: context and motivation.]

## My Solution — [short label]

- [Feature or implementation detail]
- [Feature or implementation detail]

## Tech Stack

[Short paragraph or bullets describing tools used.]

## Results

[Outcomes, impact, or reflections.]
```

### Common conventions (both patterns)

- Use `##` (H2) for all sections — never `#` in body except Pattern B's optional top heading.
- Feature bullets: `**Bold Label** — description of what it does` (em-dash, not hyphen).
- External links use inline markdown: `[display text](URL)`.
- Tone is casual and first-person for personal projects; slightly more formal in the abstract for academic ones.
- No images embedded in body — use YouTube shortcode or a cover image via frontmatter.

---

## File Naming & Location

```
content/projects/{kebab-case-project-name}.md
```

Examples: `poet-ai.md`, `college-helper.md`, `global-entry-appointment-scrapper.md`

---

## After Creating

1. **No layout changes needed** — `layouts/projects/single.html` and `list.html` are fully parameterized.
2. **No CSS changes needed** unless you introduced a new `context` value.
   - If new: add `.project-context--{value} { ... }` in `assets/css/extended/custom.css`, following existing badge patterns.
3. **No data files needed** — projects are frontmatter-driven.
4. Verify with `hugo server -D`:
   - `/projects/` list page: card shows title, context badge, tags, GitHub/Demo links
   - `/projects/{slug}/`: meta bar (context badge, status badge, links), body content, ToC
   - Dark mode renders correctly
