Status: ready-for-agent

# 01 — Devise + User model

## Parent

PRD: `.scratch/note-taking-app/PRD.md`

## What to build

Add the `devise` gem and run `rails generate devise:install`. Generate a `User` model with `database_authenticatable`, `validatable`, and `recoverable` modules. Configure Devise routes (`/users/sign_in`, `/users/sign_out`, `/users/password`). Configure the Devise mailer for password recovery (use default settings in development; production SMTP config is documented elsewhere).

Do NOT add `registerable`, `confirmable`, or `rememberable`.

Create users via `rails console` only — no seed, no registration UI.

## Acceptance criteria

- [ ] `User` model exists with Devise modules: `database_authenticatable`, `validatable`, `recoverable`
- [ ] Devise routes respond: `/users/sign_in`, `/users/sign_out`, `/users/password/new`
- [ ] A user created via `User.create!(email: ..., password: ...)` can sign in with those credentials
- [ ] Tests verify the model and sign-in flow

## Blocked by

None — can start immediately.