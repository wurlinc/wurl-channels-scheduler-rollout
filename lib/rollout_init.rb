require 'rox/server/rox_server'

puts "running rollout init"

class RolloutInit
  def self.init
    puts "running rollout initialize"

    if defined?(RSpec) == 'constant' && Rails.env.test?
      puts "Using RSpec. NOT starting Rox server - your specs are responsible of setting flags so"
      puts "you can test all conditions and tests don't fail on environmental conditions."
      puts "See spec/support/spec_helper_rox_flags.rb"
    else
      rox_log_level = :debug
      # Log when you fetch configuration
      configuration_fetched_handler = proc do |e|
        if e.has_changes
          Rails.logger.send(rox_log_level, "ROX: applied-from=#{e.fetcher_status} creation-date=#{e.creation_date} has-changes=#{e.has_changes} error=#{e.error_details}")
        elsif rox_log_level != :debug
          # Try not to log unnecessarily. If you have your rox_log_level to :info, use :debug. Otherwise use :trace if available, or don't do anything.
          level = Rails.logger.respond_to?(:trace) ? :trace : :debug
          Rails.logger.trace("ROX: applied-from=#{e.fetcher_status} creation-date=#{e.creation_date} has-changes=#{e.has_changes} error=#{e.error_details}")
        end
      end
      # Log when there is an "impression" on the flag.
      impression_handler = lambda do |e|
        if !e.experiment.nil?
          Rails.logger.send(rox_log_level, "ROX: flag #{e.reporting_value.name} value is #{e.reporting_value.value}, it is part of #{e.experiment.name} experiment, that has those labels: #{e.experiment.labels.join(',')}")
        else
          Rails.logger.send(rox_log_level, "ROX: no experiment configured for flag #{e.reporting_value.name}. default value #{e.reporting_value.value} was used")
        end
      end
      
      if ENV["ROX_CLIENT_KEY"]
        options = Rox::Server::RoxOptions.new(
          configuration_fetched_handler: configuration_fetched_handler,
          impression_handler: impression_handler,
          logger: Rails.logger
        )
        Rox::Server::RoxServer.register('wurl', FeatureFlags.instance)
        Rox::Server::RoxServer.setup(ENV["ROX_CLIENT_KEY"], options).join
      else
        puts "WARNING: No Rollout.io configuration. Set ROX_CLIENT_KEY to get feature flags to work."
      end
    end
  end
end