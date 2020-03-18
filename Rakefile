#!/usr/bin/env rake
# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

# rubocop:disable Style/ExpandPathArguments
require File.expand_path('../config/application', __FILE__)
# rubocop:enable Style/ExpandPathArguments

WurlChannelsScheduler::Application.load_tasks

# HACK: https://github.com/heroku/heroku-buildpack-ruby/issues/543
task 'db:schema:load' do
  Rake::Task['db:structure:load'].invoke
end
