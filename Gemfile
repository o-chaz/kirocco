source "https://rubygems.org"

ruby "3.1.4"

# --- Rails core ---
gem "rails", "~> 7.1.5", ">= 7.1.5.2"
gem "puma", ">= 5.0"
gem "pg", "~> 1.1"

# --- Asset management ---
gem "sprockets-rails"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# --- Styles / Frontend ---
gem "sassc-rails"
gem "bootstrap", "~> 5.3"
gem "popper_js", "~> 2.11"

# --- Other utilities ---
gem "jbuilder"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[ windows jruby ]

# --- Authentication ---
gem "devise"

group :development, :test do
  gem "debug", platforms: %i[mri windows]
end

group :development do
  gem "web-console"
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
