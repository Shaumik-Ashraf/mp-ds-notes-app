Status: ready-for-agent

# 04 — Brutalist UI theming

## Parent

PRD: `.scratch/note-taking-app/PRD.md`

## What to build

Apply a brutalist/minimal custom CSS theme across all app views. normalize.css is already present at `app/assets/stylesheets/normalize.css` — wire it into the asset pipeline (import it in `application.css`). Then write a custom `app/assets/stylesheets/application.css` theme covering:

- **Typography**: System font stack, large readable text, strong headings
- **Layout**: Centered max-width container, generous whitespace, minimal chrome
- **Navigation bar**: User email display + sign out link, subtle borders
- **Sign-in page**: Centered form, minimal styling, clear error messages (Devise default flash messages)
- **Note index**: List of notes showing first line as title, clear hover states, obvious action links (view, edit, delete)
- **Note show/edit/new forms**: Clean form layout, full-width textarea, clear submit/cancel buttons
- **Delete link**: Already styled — the JS confirmation is handled in Slice 5

The aesthetic should be functional, unadorned, with strong typographic hierarchy and generous whitespace. Think Brutalist Web design: black text on white background, monochrome, heavy horizontal rules, no gradients/shadows/rounded corners.

Do NOT modify any HTML structure from the scaffold — only CSS.

## Acceptance criteria

- [ ] normalize.css is wired into the asset pipeline and loaded on every page
- [ ] Custom CSS provides a complete brutalist/minimal theme across all views
- [ ] Theme is responsive (works on mobile and desktop within reason)
- [ ] No HTML changes to scaffold views — purely CSS

## Blocked by

- `.scratch/note-taking-app/issues/03-note-scaffold-encryption-auth.md`