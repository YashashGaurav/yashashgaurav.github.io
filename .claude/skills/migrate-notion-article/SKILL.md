---
name: migrate-notion-article
description: Migrate an article/blog post page from Notion to the Hugo portfolio
---

# Migrate Notion Article

## Before You Start

Gather the following from the Notion page (ask the user for dates since they're not on public pages):

| Field | Source | Notes |
|-------|--------|-------|
| Title | Notion page title | Title-cased |
| Date | User provides from Notion workspace | Format: `YYYY-MM-DD` |
| Tags | Content-specific keywords | e.g. `"Protobuf"`, `"Homebrew"`, `"M1 Mac"` |
| Categories | Notion "Tags" column value | `"Programming"`, `"Automation"`, `"LifeThings"`, `"AI/ML/DL"` |
| Description | One-line summary | For SEO and list cards |
| Cover Image | Notion page cover (if any) | Download to `static/images/posts/` before URL expires |
| Body Type | Content structure | Tutorial (A), Guide (B), or Notes (C) |

---

## Front Matter Template

```yaml
---
title: "Article Title"
date: YYYY-MM-DD
draft: false
tags: ["Tag1", "Tag2"]
categories: ["Category"]
author: "Yashash Gaurav"
showToc: true
description: "One-sentence description for SEO and list cards."
cover:
  image: "/images/posts/{slug}_cover.{ext}"
  alt: "Descriptive alt text"
  hidden: false
---
```

**Field notes:**
- `cover.hidden: false` overrides the site-level `cover.hidden: true` to show the image on the post page.
- `showToc` is always `true` for articles with multiple sections.
- `draft` is always `false` for published content.
- `categories` maps directly to the Notion "Tags" column (the broad topic label).
- `tags` are content-specific keywords not captured by categories.

---

## Body Patterns

### Pattern A — How-to / Tutorial

Use for step-by-step technical guides (e.g., protobuf install, VSCode Quick Actions, AWS VNC).

```markdown
## Prerequisites

[What the reader needs before starting — tools, accounts, existing setup.]

## Step 1: [First major action]

[Explanation paragraph.]

```bash
[code block]
```

## Step 2: [Next action]

...

## Final Configuration / Verification

[Wrap-up step confirming success.]
```

### Pattern B — Guide / Walkthrough

Use for process walkthroughs with requirements and tips (e.g., passport renewal).

```markdown
## Overview

[Brief intro: what this guide covers and who it's for.]

## Requirements

- [Requirement 1]
- [Requirement 2]

## The Process

### Step 1: [Phase name]

[Details for this phase.]

## Tips & Gotchas

- [Tip or common pitfall]
```

### Pattern C — Technical Notes

Use for study notes and concept summaries (e.g., few-shot learning).

```markdown
## Introduction

[Context: why this topic matters, source material.]

## Key Concepts

### [Concept 1]

[Explanation.]

### [Concept 2]

[Explanation.]

## Summary

[One-paragraph synthesis of the key takeaways.]

## References

- [Source 1](URL)
```

### Common conventions (all patterns)

- Use `##` (H2) for top-level sections, `###` (H3) for sub-sections.
- Code blocks use the language annotation for Chroma highlighting: ` ```bash `, ` ```python `, etc.
- External links use inline markdown: `[display text](URL)`.
- Inline code (file paths, commands) uses backticks: `` `~/.zshrc` ``.
- Tone is casual and first-person.

---

## Image Handling

**Cover image:**
- Download from Notion before the URL expires (Notion image URLs are temporary).
- Save to: `static/images/posts/{slug}_cover.{ext}`
- Reference via `cover.image` in front matter.

**Inline images:**
- Save to: `static/images/posts/{slug}_{descriptor}.{ext}`
- Reference in body: `![alt text](/images/posts/{slug}_{descriptor}.{ext})`

---

## File Naming & Location

```
content/posts/{kebab-case-article-title}.md
```

Examples: `installing-protobuf-m1-mac.md`, `passport-renewal-sf.md`

---

## After Creating

1. **No layout changes needed** — PaperModX renders posts using its default `single.html`.
2. **No CSS changes needed** — post styles are handled by PaperModX.
3. **No data files needed** — articles are fully front-matter + body driven.
4. Verify with `hugo server -D`:
   - `/posts/` list page: article card shows title, description, cover image, tags
   - `/posts/{slug}/`: cover image visible, code blocks highlighted, ToC works, links work
   - Tag pages (e.g. `/tags/protobuf/`) list the article correctly
   - Dark mode renders correctly
