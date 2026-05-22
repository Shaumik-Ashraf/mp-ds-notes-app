Status: ready-for-agent

# PRD: Production-Grade Note-Taking Web App

## Problem Statement

A user needs a secure, production-grade note-taking web application where they can sign in, manage plain-text notes that are encrypted at rest, and deploy via Docker/Kamal. The app must have no self-registration — users are provisioned by an operator via CLI.

## Solution

A Ruby on Rails 8.1 web app with Devise authentication, Active Record Encryption for note bodies, a brutalist/minimal vanilla CSS/JS frontend, and a Kamal-based Docker deployment pipeline.

## User Stories

1. As a User, I want to sign in with my email and password, so that I can access my private notes.
2. As a User, I want to see a list of all my notes (showing the first line as title), so that I can quickly find the note I need.
3. As a User, I want to create a new note, so that I can capture plain-text information.
4. As a User, I want to edit an existing note, so that I can update its content.
5. As a User, I want to view a single note's full content, so that I can read it in detail.
6. As a User, I want to permanently delete a note (with a confirmation prompt), so that I can remove information I no longer need.
7. As a User, I want to sign out, so that I can end my session securely.
8. As an Operator, I want to add new Users via the Rails console (or `kamal exec` in production), so that team members can access the app without self-registration.
9. As an Operator, I want to reset a User's password via the Devise "forgot password" flow, so that they can recover access without my intervention.
10. As a Deployer, I want to deploy the app with Kamal to a Docker host, so that it runs in production with Solid Queue/Cache/Cable on SQLite.

## Implementation Decisions

- **Authentication**: Devise with `database_authenticatable`, `validatable`, `recoverable` modules. No `registerable`, no `confirmable`, no `rememberable`.
- **User identity**: Email as login identifier. No username.
- **User provisioning**: No seed, no admin UI, no admin role. Operator uses `rails console` (or `kamal exec 'rails console'` in production) to create users via `User.create!(email: ..., password: ...)`.
- **Note model**: Single `body` text column. First line acts as title in the UI. Owned by a `User` via `belongs_to`.
- **Encryption**: Non-deterministic Active Record Encryption on `Note#body` (see ADR-0001).
- **Delete**: Hard `DELETE FROM notes` with a JavaScript `confirm()` prompt before firing the request.
- **Routes**: Root `/` → notes index. Devise sign in at `/users/sign_in`. Notes CRUD at `/notes`. Unauthenticated requests redirect to sign in.
- **Frontend**: Vanilla CSS with normalize.css + brutalist/minimal custom theme. Vanilla JS using `fetch()` and `addEventListener` for all interactivity. No Turbo/Stimulus (turbo-rails and stimulus-rails removed from Gemfile).
- **Password reset**: `recoverable` enabled; Action Mailer configuration documented in README for production. In development, use `letter_opener` or similar.
- **Deployment**: Kamal + Docker (existing Dockerfile and `config/deploy.yml` from Rails 8 default). Solid Queue/Cache/Cable for production background processing on SQLite.

## Modules

- **User model** (`app/models/user.rb`) — Devise-enabled, `has_many :notes`
- **Note model** (`app/models/note.rb`) — `belongs_to :user`, `encrypts :body`, scoped to user
- **NotesController** (`app/controllers/notes_controller.rb`) — full CRUD, Devise `authenticate_user!` before action
- **Sessions** — handled entirely by Devise (no custom session controller needed unless customization arises)
- **Views** — `app/views/notes/` (scaffold-generated then customized), `app/views/layouts/application.html.erb` (nav with sign out link, user email display)
- **CSS** — `app/assets/stylesheets/application.css` (normalize.css via importmap or CDN + custom brutalist theme)
- **JS** — `app/javascript/application.js` (vanilla JS for delete confirmation and any future interactivity)
- **README** — setup instructions, user provisioning steps, Action Mailer config for production, deploy commands

## Testing Decisions

- **What makes a good test**: Test external behavior (HTTP responses, redirects, DB state), not implementation details (internal method calls, encryption internals).
- **Model tests**: Validate User (email presence, password length via Devise validatable) and Note (belongs_to user, body presence, encryption module presence).
- **Controller/integration tests**: Test CRUD endpoints with authenticated and unauthenticated access. Verify redirect to sign in when not logged in. Verify note scoping (User A cannot see User B's notes). Verify delete actually removes the record.
- **System tests**: One happy-path system test: sign in → create note → see it in list → edit it → view it → delete it.
- **Prior art**: Rails scaffold-generated tests provide the pattern for `test/controllers/` and `test/system/`.

## Out of Scope

- User registration UI
- Admin role or admin dashboard
- Soft-delete / trash / recycle bin
- Rich text formatting (markdown, HTML)
- Note sharing between users
- Full-text search
- API endpoints
- PWA / service worker
- Email infrastructure setup (documented but not implemented)

## Further Notes

- Action Mailer config (SMTP host/port/user/pass) will be documented in README as production environment variables set via Kamal secrets.
- normalize.css will be added via importmap when CSS implementation begins.
- The scaffold-generated views will be customized for the brutalist theme during implementation.