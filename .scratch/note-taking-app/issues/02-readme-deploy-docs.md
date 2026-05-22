Status: ready-for-agent

# 02 — README + deploy docs

## Parent

PRD: `.scratch/note-taking-app/PRD.md`

## What to build

Update the README with:

1. **Setup instructions** — `bin/setup`, dev server via `bin/dev`
2. **User provisioning** — how to create users via `rails console` (and `kamal exec 'rails console'` in production)
3. **Action Mailer configuration for production** — document the SMTP environment variables needed (`SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, `SMTP_PASS`) and how to set them via Kamal secrets
4. **Kamal deploy** — basic deploy command and prerequisites (Docker, registry config)
5. **Architecture notes** — brief note that Hotwire is removed, vanilla JS used, notes encrypted with AR encryption

## Acceptance criteria

- [ ] README contains setup instructions
- [ ] README documents how to provision a user via console
- [ ] README documents Action Mailer config for production
- [ ] README documents basic Kamal deploy workflow

## Blocked by

None — can start immediately (independent of code implementation).