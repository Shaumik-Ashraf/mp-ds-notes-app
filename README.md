# MP DS Notes

A production-grade note-taking web application. Users sign in to create, edit, view, and permanently delete plain-text notes. All notes are encrypted on disk via Active Record Encryption. No self-registration — users are provisioned by an operator via `rails console`.

Built with Ruby on Rails 8.1, Devise authentication, SQLite3, and a brutalist/minimal vanilla CSS/JS frontend. Deployed via Kamal on Docker.

## Prerequisites

- Ruby 4.0.1
- SQLite3
- Docker (for production deployment)
- Kamal (`gem install kamal`)

## Setup (development)

```sh
bin/setup
bin/dev
```

The app will be at `http://localhost:3000`.

### Creating a user

No self-registration is available. Create users via the Rails console:

```sh
bin/rails console
> User.create!(email: "user@example.com", password: "a-secure-password")
```

The password must be at least 6 characters.

## Production deployment (Kamal)

### 1. Configure your registry

Edit `config/deploy.yml` — set your image name, registry server, and credentials in `.kamal/secrets`.

### 2. Configure environment variables

Set these via Kamal secrets in `.kamal/secrets`:

| Variable | Description |
|---|---|
| `RAILS_MASTER_KEY` | Rails master key (for encrypted credentials and AR encryption) |

### 3. Deploy

```sh
bin/kamal deploy
```

### 4. Creating a user in production

```sh
bin/kamal console
> User.create!(email: "user@example.com", password: "a-secure-password")
```

### Password recovery (production)

Action Mailer must be configured for password reset emails to work. Set these environment variables via Kamal secrets:

| Variable | Description | Example |
|---|---|---|
| `SMTP_HOST` | SMTP server hostname | `smtp.example.com` |
| `SMTP_PORT` | SMTP server port | `587` |
| `SMTP_USER` | SMTP username | `postmaster@example.com` |
| `SMTP_PASS` | SMTP password | (secret) |

Then configure Action Mailer in `config/environments/production.rb` to use these values. The deploy.yml `env.secret` list must include any env vars needed at runtime.

## Architecture notes

- **No Hotwire**: `turbo-rails` and `stimulus-rails` are removed. The frontend uses vanilla JS (`fetch` + `addEventListener`).
- **Encryption**: Note bodies are encrypted at rest using non-deterministic Active Record Encryption (see `docs/adr/0001-non-deterministic-ar-encryption.md`).
- **Database**: SQLite3 for all environments. Solid Queue/Cache/Cable for production background processing.

## Running tests

```sh
bin/rails test           # unit + integration tests
bin/rails test:system    # system tests (requires ChromeDriver)
bin/rubocop              # lint
```

## CI

CI runs on GitHub Actions: Brakeman scan, bundler-audit, importmap audit, RuboCop, and tests. See `.github/workflows/ci.yml`.