# rails-template

Rails 8.1 application template. Generates a new app with the full opinionated stack in one command.

## Stack

- **Ruby** 4.0.3 · **Rails** 8.1
- **Frontend** Hotwire (Turbo + Stimulus) · Tailwind CSS v4 · Importmap · Propshaft
- **Database** SQLite + Solid Cache/Queue/Cable
- **Testing** RSpec · FactoryBot · Shoulda Matchers · DatabaseCleaner · Guard
- **Quality** Rubocop omakase · Brakeman · Bundler-audit
- **Deployment** Kamal + Docker + Thruster
- **Dev** OrbStack devcontainer

## Usage

```bash
rails new myapp \
  -d sqlite3 \
  --asset-pipeline=propshaft \
  --javascript=importmap \
  --skip-test \
  --template=/path/to/rails-template/template.rb
```

Or clone this repo and reference it:

```bash
git clone git@github.com:you/rails-template.git ~/code/rails-template

rails new myapp -d sqlite3 --asset-pipeline=propshaft --javascript=importmap \
  --skip-test --template=~/code/rails-template/template.rb
```

## What gets generated

- `app/views/layouts/application.html.slim` — Slim layout with Hotwire Native body class + modal turbo-frame
- `app/views/shared/_nav.html.slim` — nav stub (hidden on native)
- `app/assets/tailwind/application.css` — design token system (`--app-*`), core components, Hotwire Native overrides
- `app/javascript/controllers/modal_controller.js` — Turbo Frame modal with backdrop + Escape
- `app/controllers/application_controller.rb` — includes `Turbo::Native::Navigation`
- `spec/` — RSpec skeleton with FactoryBot, DatabaseCleaner, Shoulda Matchers wired up
- `.devcontainer/` — OrbStack-ready devcontainer

## Conventions generated apps should follow

- Slim views. No ERB.
- `t()` for all user-facing strings. Keys sorted alphabetically in `en.yml`.
- Array path syntax (`[@record]`, `[:edit, @record]`) — never named route helpers.
- `content_for :title` on every view (used for native OS nav bar title).
- `recede_or_redirect_to` on mutating actions (pops native screen, normal redirect on web).
- `:unprocessable_content` in controllers and specs.

## Design tokens

Edit the `:root` block in `app/assets/tailwind/application.css`. Tokens are exposed to Tailwind as `bg-app-surface`, `text-app-accent`, etc. Dark mode uses `html.dark`.

## Modal pattern

```slim
/ Trigger link
= link_to "New thing", new_thing_path, data: { turbo_frame: "modal" }

/ new.html.slim
= turbo_frame_tag "modal"
  .app-modal-overlay data-controller="modal" data-action="click->modal#backdropClick"
    .app-modal
      .app-modal__header
        h2 New thing
        button.app-modal__close data-action="click->modal#close" ×
      .app-modal__body
        = form_with ... data: { turbo_frame: "_top" }
```

## Updating the template

Edit files in `templates/` and `template.rb`. Files ending in `.tt` are ERB — use `<%= app_name %>` etc. for substitution. No Rails app files live in this repo.
