Status: ready-for-agent

# 05 — Remove Turbo/Stimulus + vanilla JS delete confirmation

## Parent

PRD: `.scratch/note-taking-app/PRD.md`

## What to build

Remove `turbo-rails` and `stimulus-rails` from the Gemfile and run `bundle`. Update `app/javascript/application.js` to remove any Turbo/Stimulus imports.

Replace the scaffold-generated destructive link (`link_to "Destroy"`) with a vanilla JS approach:

- Render a regular `<button>` or `<a>` that fires a `fetch('/notes/:id', { method: 'DELETE' })` request
- Show a `confirm()` dialog before the request fires
- On success, redirect to the notes index (or remove the element in-place — redirect is simpler)
- On error, show an alert or flash message

This uses `addEventListener` and `fetch` — no framework, no UJS `data-turbo-method`.

## Acceptance criteria

- [ ] `turbo-rails` and `stimulus-rails` removed from Gemfile and lockfile
- [ ] `app/javascript/application.js` contains no Turbo/Stimulus imports
- [ ] Delete button shows a confirmation prompt and fires a DELETE fetch request
- [ ] Successful delete redirects to notes index
- [ ] All other note interactions (create, edit) continue to work via standard form submissions (no Turbo needed)
- [ ] Tests pass

## Blocked by

- `.scratch/note-taking-app/issues/03-note-scaffold-encryption-auth.md`