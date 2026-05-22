Status: ready-for-agent

# 03 — Note scaffold + encryption + auth gate

## Parent

PRD: `.scratch/note-taking-app/PRD.md`

## What to build

Run `rails generate scaffold Note user:references body:text` to produce model, migration, controller, views, and routes. Then customize:

- **Model**: Add `encrypts :body` (non-deterministic). Add `validates :body, presence: true`. The `belongs_to :user` comes from the scaffold generator.
- **Controller**: Add `before_action :authenticate_user!` (Devise). Scope all queries to `current_user.notes`. Redirect to root after successful create/update/delete (standard scaffold convention).
- **Routes**: Set root to `notes#index`. Remove any unused scaffold routes. Devise routes are already set up from Slice 1.
- **Index view**: Show each note's first line as the title. Link to show, edit, destroy.
- **Scoped access**: Ensure a logged-in user can only see/edit/delete their own notes. Attempting to access another user's note should return 404 or redirect.

Do NOT customize CSS or the delete behavior yet — those are separate slices.

## Acceptance criteria

- [ ] `Note` model exists with `belongs_to :user`, `encrypts :body`, presence validation
- [ ] Migration creates `notes` table with `user_id` and `body` columns
- [ ] Authenticated user can create, view list, view single, edit, and delete notes
- [ ] Unauthenticated access redirects to sign-in page
- [ ] User A cannot access User B's notes (404 or redirect)
- [ ] Root path (`/`) shows the notes index for authenticated users
- [ ] Tests cover model validation, authenticated CRUD, unauthenticated redirect, and owner scoping

## Blocked by

- `.scratch/note-taking-app/issues/01-devise-user-model.md`