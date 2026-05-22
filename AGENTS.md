# AGENTS.md — mp-ds-notes

## Stack
- Rails 8.1, Ruby 4.0.1, SQLite3
- Propshaft (asset pipeline), Importmap (JS), Hotwire (Turbo + Stimulus)
- Production: Kamal Docker deploy, Thruster server, Solid Queue/Cache/Cable (SQLite-backed)

## No git writes from agent
The LLM agent MUST NOT stage, commit, push, or otherwise write to git. Only the user handles git operations. The agent may request the user perform git operations.

## Developer commands

| Action | Command |
|---|---|
| Dev server | `bin/dev` (alias for `rails server`) |
| Setup | `bin/setup` (bundle + db:prepare, then starts server) |
| Run all tests | `bin/rails test` |
| Run single test | `bin/rails test test/models/foo_test.rb:LINE` |
| Run system tests | `bin/rails test:system` |
| Lint | `bin/rubocop` |
| Autofix lint | `bin/rubocop -a` |
| Security audit | `bin/brakeman --no-pager && bin/bundler-audit` |
| JS audit | `bin/importmap audit` |
| Full CI (local) | `bin/ci` (setup -> rubocop -> security -> test -> seed) |
| Console | `bin/rails console` |
| Generate | `bin/rails generate` (scaffold, model, etc.) |

## Testing
- **MiniTest** (not RSpec), ActiveSupport::TestCase, YAML fixtures
- Parallel by default (`parallelize(workers: :number_of_processors)`)
- DB: `storage/test.sqlite3` -- run `bin/rails db:test:prepare` after migrations
- System tests: Capybara + Selenium, screenshots saved to `tmp/screenshots`

## CI pipeline (`.github/workflows/ci.yml`)
1. `bin/brakeman --no-pager`
2. `bin/bundler-audit`
3. `bin/importmap audit`
4. `bin/rubocop -f github`
5. `bin/rails db:test:prepare test`
6. `bin/rails db:test:prepare test:system` (optional, screenshots uploaded on failure)

## Available skills (Matt Pocock)
Skills listed in `skills-lock.json`: caveman, diagnose, grill-me, grill-with-docs, handoff, improve-codebase-architecture, prototype, setup-matt-pocock-skills, tdd, to-issues, to-prd, triage, write-a-skill, zoom-out. Load via the `skill` tool.

## Config files of note
- `config/routes.rb` -- only health check route (`/up`)
- `config/database.yml` -- separate production DBs for cache, queue, cable
- `config/deploy.yml` -- Kamal config, single web server, localhost:5555 registry
- `config/ci.rb` -- local CI steps (used by `bin/ci`)
- `.rubocop.yml` -- inherits `rubocop-rails-omakase`
- `.ruby-version` -- `ruby-4.0.1`
- `Gemfile` -- solid_* trilogy for production background/cache/cable