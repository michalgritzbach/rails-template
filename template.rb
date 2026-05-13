# Rails 8.1 Template
#
# Usage:
#   rails new myapp -d sqlite3 --asset-pipeline=propshaft --javascript=importmap \
#     --skip-test --template=/path/to/rails-template/template.rb
#
# Produces: Hotwire, Tailwind CSS v4, Slim, RSpec, devcontainer (OrbStack), Kamal.

def source_paths
  [File.expand_path("templates", __dir__)]
end

# ── Gems ──────────────────────────────────────────────────────────────────────

gem "image_processing", "~> 1.2"
gem "simple_form"
gem "slim-rails"
gem "tailwindcss-rails"

gem_group :development, :test do
  gem "brakeman",                  require: false
  gem "bundler-audit",             require: false
  gem "database_cleaner-active_record"
  gem "factory_bot_rails"
  gem "faker"
  gem "guard"
  gem "guard-rspec",               require: false
  gem "rspec-rails"
  gem "rubocop-rails-omakase",     require: false
  gem "shoulda-matchers"
end

# ── After bundle ──────────────────────────────────────────────────────────────

after_bundle do
  # ── Test framework ──────────────────────────────────────────────────────────
  remove_dir "test"
  generate "rspec:install"
  remove_file "spec/rails_helper.rb"
  template "rails_helper.rb.tt",       "spec/rails_helper.rb"
  template "database_cleaner.rb.tt",   "spec/support/database_cleaner.rb"
  template "factory_bot.rb.tt",        "spec/support/factory_bot.rb"
  template "shoulda_matchers.rb.tt",   "spec/support/shoulda_matchers.rb"

  # ── Tailwind ─────────────────────────────────────────────────────────────────
  run "bin/rails tailwindcss:install"
  remove_file "app/assets/tailwind/application.css"
  template "application.css.tt", "app/assets/tailwind/application.css"

  # ── Layouts ───────────────────────────────────────────────────────────────────
  remove_file "app/views/layouts/application.html.erb"
  template "application.html.slim.tt", "app/views/layouts/application.html.slim"
  remove_file "app/views/layouts/mailer.html.erb"
  template "mailer.html.slim.tt",      "app/views/layouts/mailer.html.slim"
  template "_nav.html.slim.tt",        "app/views/shared/_nav.html.slim"

  # ── Home page ─────────────────────────────────────────────────────────────────
  generate :controller, "pages", "home", "--no-helper", "--no-assets", "--no-test-framework"
  remove_file "app/views/pages/home.html.erb"
  template "home.html.slim.tt", "app/views/pages/home.html.slim"
  route 'root "pages#home"'

  # ── ApplicationController ─────────────────────────────────────────────────────
  remove_file "app/controllers/application_controller.rb"
  template "application_controller.rb.tt", "app/controllers/application_controller.rb"

  # ── Stimulus controllers ──────────────────────────────────────────────────────
  template "modal_controller.js.tt", "app/javascript/controllers/modal_controller.js"

  # ── simple_form ───────────────────────────────────────────────────────────────
  generate "simple_form:install"

  # ── Config files ─────────────────────────────────────────────────────────────
  template ".rubocop.yml.tt",  ".rubocop.yml"
  template "Guardfile.tt",     "Guardfile"
  remove_file "config/locales/en.yml"
  template "en.yml.tt", "config/locales/en.yml"

  # ── Devcontainer ─────────────────────────────────────────────────────────────
  template "devcontainer.json.tt",     ".devcontainer/devcontainer.json"
  template "compose.yaml.tt",          ".devcontainer/compose.yaml"
  template "devcontainer_Dockerfile.tt", ".devcontainer/Dockerfile"

  # ── Initial commit ────────────────────────────────────────────────────────────
  git :init
  git add: "-A"
  git commit: %(-m "Initial commit from rails-template")
end
