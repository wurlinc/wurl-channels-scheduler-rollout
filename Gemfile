source 'https://rubygems.org'

ruby ENV['WURL_RUBY_VERSION'] || "~> 2.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.11.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'fastimage'

#  Because of CVE-2018-3760....
gem  "sprockets", "~> 3.7.2"

# Use jquery as the JavaScript library. TODO Remove
gem 'jquery-rails', '~> 4.2.2'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# Not using it on 2.0, and it interferes with format.json for some reason.
# gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Puma as the app server
gem 'puma', '~> 4.3.3'

gem 'loofah', '~> 2.3.1'

gem 'foreman', '~> 0.83.0'
gem 'hashie', '3.4.6'
gem 'bootstrap-sass', '~> 3.4.1'
gem 'autoprefixer-rails', '~> 6.7.6'
gem 'activeresource', '~> 4.1.0'
gem 'protected_attributes', '~> 1.1.4'
gem 'deep_cloneable', '~> 2.2.0'
gem "paperclip", '~> 5.2.0'

gem 'will_paginate', '~> 3.1.0'

gem 'acts_as_list'
gem 'chronic', require: false
gem 'rest-client'

gem "react_on_rails", '11.0.3'
gem 'ice_cube'            # Ruby Date Recurrence Library - Allows easy creation of recurrence rules and fast querying
# Secureheaders 5
gem 'secure_headers', git: 'https://github.com/twitter/secureheaders.git', branch: 'master'
gem "rack-timeout", "~> 0.5.1"
gem 'rack-cors', :require => 'rack/cors'
gem 'rack-attack'
gem 'kramdown', require: false
gem 'scientist'
gem 'json_converter', require: false
gem 'platform-api', require: true
gem 'google_drive', require: false
gem 'timecode'
# Avoid a version `CXXABI_1.3.9' not found
gem 'eventmachine', '~> 1.2.7'
gem 'm3u8'
# siren lib dependencies
# group :siren do
  gem 'oat', require: false, git: 'https://github.com/apsoto/oat.git', branch: 'master'
# end
gem 'diffy'
gem 'activerecord-diff'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 9.0.6'
end

group :development do
  # Rim bundle exec derailed bundle:mem to see Gem memory footprint.
  gem 'derailed_benchmarks'
  gem "memory_profiler"

  gem 'stackprof', require:false # Dockerfiles using slim. Do not install profilers because profiling code is stripped.
  gem 'ruby-prof', require: false

  # Access an IRB console on exception pages or by using <%= console %> in views
  # Note Better_errors and web_console will remove our exception functionality,
  # Which is also a lot less useful on API development, as it's focused on
  # expecting HTML responses.
  # So they "ship" disabled.
  # Test with these two commented out every once in a while.
  # gem 'web-console', '~> 2.0'
  # gem 'better_errors', '~> 2.5.1'
  # gem 'binding_of_caller', '~> 0.8.0'

  gem 'pry-rails', '~> 0.3.5'
  gem 'pry-remote'
  gem 'pry-stack_explorer'
  gem 'awesome_print'
end

gem 'mini_racer', '~>0.2.6',  platforms: :ruby

gem "json", "~> 1.8"

gem "rox-rollout", "~> 4.0"

gem 'sqlite3', '~> 1.3.6', '< 1.4'
