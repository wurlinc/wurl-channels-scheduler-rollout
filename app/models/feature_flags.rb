# frozen_string_literal: true

require 'rox/server/flags/rox_flag'
require 'singleton'

# Feature flags instance.
# To set a feature flag:
# 1. add an attr_accessor. Please document it.
# 2. Add it to the ALL_FLAGS array.
# You will see the value of the property on the Redux store
# (see MainController#feature_flags)
class FeatureFlags
  include Singleton

  # keep in alpha-order, makes diffs easier
  attr_accessor :rolloutTest
  attr_accessor :featureFlagOverrides

  # List all flags so we can pass them on to FeatureFlags.tsx via the redux model.
  # keep in alpha-order, makes diffs easier
  ALL_FLAGS = %w[
    rolloutTest
    featureFlagOverrides
  ].freeze

  def initialize
    ### Define custom properties here ###
    set_content_partner_context
    set_email_context
    set_admin_context
    set_channel_context

    define_flags
  end

  private

  ##########################################################################
  # context setup methods
  #
  # Accept both string and symbol keys in order to avoid potential context definition errors
  # NOTE: prefer individual methods to keep the cyclomatic complexity of #initialize low
  #       (and rubocop will complain otherwise), but it's generally simpler to understand
  #       when the methods are smaller and named appropriately

  def set_content_partner_context
    Rox::Server::RoxServer.set_custom_int_property('contentPartner') do |context|
      user = context['user'] || context[:user]
      cp_id = context['content_partner_id'] || context[:content_partner_id]
      cp_id || user&.content_partner_id
    end
  end

  def set_email_context
    Rox::Server::RoxServer.set_custom_string_property('email') do |context|
      user = context['user'] || context[:user]
      user&.email
    end
  end

  def set_admin_context
    Rox::Server::RoxServer.set_custom_boolean_property('admin') do |context|
      user = context['user'] || context[:user]
      user&.can_admin?
    end
  end

  def set_channel_context
    Rox::Server::RoxServer.set_custom_string_property('channel') do |context|
      (context['channel_id'] || context[:channel_id])&.to_s
    end
  end

  def define_flags
    ### Define flags here and set att_accessor above ###
    ALL_FLAGS.each do |flag_name|
      method_name = "#{flag_name}="
      new_flag = Rox::Server::RoxFlag.new
      send(method_name, new_flag)
    end
  end
end
