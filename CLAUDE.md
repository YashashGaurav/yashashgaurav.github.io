# Claude Code Project Guidelines

## Project Context

- **Goal:** Personal portfolio migration from Notion to Hugo.
- **Tech:** Hugo, PaperModX, HTML/CSS, Playwright.
- **State:** Migrating content iteratively. MVP -> CV -> Posts -> Projects.

## Documentation (Read-Only)

- Project Goals & Status: `project_spec.md`
- Tech Stack & Data Models: `architecture_spec.md`

## Slash Commands

- **/update-progress**: Updates `project_spec.md` checklist and `architecture_spec.md` if structure changed.
- **/serve-test**: Starts `hugo server -D` and runs Playwright tests if available.

## MCP Servers

- **github-mcp-server**: For reading repo state, creating files, and managing branches.
- **filesystem**: (Native) For reading/writing local files.
- **playwright/puppeteer** (Planned): For visual regression testing of the CV layout.

## Coding Standards

- **RefactorAsYouWrite**: Keep CSS clean. Use Hugo `assets/css/extended` for custom styles.
- **Data-Driven**: Avoid hardcoding text in HTML. Use `data/` files (YAML/JSON) for structured content like CV/Timeline.
- **Images**: Store in `static/images/`. Use distinct naming (e.g., `project-name_cover.jpg`).
- **Commits**: Semantic style (e.g., `feat: add cv layout`, `chore: update specs`).
