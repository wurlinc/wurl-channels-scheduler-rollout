puts "********************* Loading Puma Development Config **************************"

# Respond to these in dev mode too, so we can test it.
workers Integer(ENV['WEB_CONCURRENCY'] || 1)
threads_count = Integer(ENV['MAX_THREADS'] || 1)
threads threads_count, threads_count

before_fork do
  puts "Puma master process about to fork. Closing existing Active record connections."
  ActiveRecord::Base.connection.disconnect!
end

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end

# So debugger doesn't timeout constantly:
worker_timeout 3600 