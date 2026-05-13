# Rails Template

Rails 8.1 starter with the full opinionated stack. Clone, rename, build.

## Stack

- **Ruby** 4.0.3 · **Rails** 8.1
- **Frontend** Hotwire (Turbo + Stimulus) · Tailwind CSS v4 · Importmap · Propshaft
- **Database** SQLite + Solid Cache/Queue/Cable
- **Auth** — not included; add `has_secure_password` + sessions as needed
- **Testing** RSpec · FactoryBot · Shoulda Matchers · DatabaseCleaner · Guard
- **Quality** Rubocop (omakase) · Brakeman · Bundler-audit
- **Deployment** Kamal + Docker + Thruster
- **Dev** OrbStack devcontainer

## Getting started

```bash
# 1. Clone and rename
git clone <this repo> myapp
cd myapp

# 2. Rename the module in config/application.rb
#    Change `module App` → `module Myapp`

# 3. Update config/deploy.yml: service, image, server IPs

# 4. Update .devcontainer/compose.yaml: add your OrbStack host to development.rb

# 5. Open in devcontainer
devcontainer open .

# 6. Inside container
bin/rails db:create db:migrate
bin/dev
```

## Conventions

- Slim views. No ERB.
- `t()` for all user-facing strings. Keys sorted alphabetically in `en.yml`.
- Array path syntax (`[@record]`, `[:edit, @record]`) — never named route helpers.
- `content_for :title` on every view for native OS nav bar titles.
- `recede_or_redirect_to` instead of `redirect_to` on mutating actions (pops native screen, redirects on web).
- `:unprocessable_content` (not `:unprocessable_entity`) in controllers.
- `@pet = Resource.find(params[:resource_id]) if params[:resource_id]` for nested+top-level routes.

## Design tokens

Edit `app/assets/tailwind/application.css` → `:root` block. Tokens use `--app-*` prefix; Tailwind exposes them as `text-app-accent`, `bg-app-surface`, etc.

## Hotwire Native

Body gets `class="turbo-native"` when a native app is detected. Use `body.turbo-native` selectors for native-specific overrides (see bottom of `application.css`). Nav is hidden on native — the OS provides its own chrome.

## Modal pattern

All CRUD forms open as modals via a single `turbo_frame_tag "modal"` in the layout.

- New/edit views: wrap content in `= turbo_frame_tag "modal"` with `.app-modal-overlay` / `.app-modal`
- Trigger links: `data: { turbo_frame: "modal" }`
- Form submit: `data: { turbo_frame: "_top" }`
- Cancel links: `data: { turbo_frame: "_top" }`
- Backdrop/escape: `modal` Stimulus controller (already included)

## Dev commands

```bash
bin/devcontainer bin/dev              # server + Tailwind watcher
bin/devcontainer bin/rails console
bin/devcontainer bin/rails db:migrate
bin/devcontainer bundle exec rspec
bin/devcontainer bin/rubocop
bin/devcontainer bin/brakeman
bin/devcontainer bundle exec bundler-audit
```
