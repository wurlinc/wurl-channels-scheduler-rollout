WurlChannelsScheduler::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  config.log_level = ENV.fetch('LOG_LEVEL', 'debug')&.to_sym
  Rack::Timeout::Logger.level  = Logger::DEBUG

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  # Turn this to false to test ExceptionsController
  # catching and rendering stuff.
  config.consider_all_requests_local       = ENV.fetch('TEST_ERROR_HANDLING', 'false') == 'true'

  # If we want to test error handling, show_exceptions must be off.
  # Also, it's silly to use show_exceptions in JSON context, and most of
  # what this app does is API, so...
  config.action_dispatch.show_exceptions = ENV.fetch('TEST_ERROR_HANDLING', 'false') == 'false'

  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.perform_deliveries = false

  config.action_mailer.default_url_options = { host: ENV['WURL_HOST'], port: 3000 }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.eager_load = false

  # NOTE: Uncomment to get workspace paging requests to work on local -Ross
  Rails.application.routes.default_url_options = { host: 'localhost', port: 3000 }
end
