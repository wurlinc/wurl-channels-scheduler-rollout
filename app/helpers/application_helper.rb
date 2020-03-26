# frozen_string_literal: true
require 'ostruct'

module ApplicationHelper

  def body_css_class
    ""
  end

  def external_path_to_main_bundle
    bundle_sha = ENV.fetch('WEBPACK_BUNDLE_SHA', "No-SHA-" + DateTime.now.iso8601)
    "/webpack/main-bundle-#{bundle_sha}.js"
  end

  def environment_name_for_title
    begin
      if Rails.env.production?
        # :nocov:
        if ! ENV['HEROKU_APP_NAME'].match(/prod/)
          return ENV['HEROKU_APP_NAME']
        end
        # :nocov:
      else
        Rails.env
      end
    rescue => e
      # :nocov:
      Logger.error(e)
      ""
      # :nocov:
    end
  end

  # assets.curate.wurl.com points to wurl-videos-prod-secure
  def secure_preview_url rendition
    return unless rendition && rendition.origin_path
    "https://#{ENV['CLOUDFRONT_HOST']}#{rendition.origin_path}"
  end


  def resolution(episode)
    return if episode.nil?
    if episode.original_height.nil? || episode.original_width.nil?
      return "<font color=\'red\'>Unknown</font>"
    elsif episode.original_height < 720 || episode.original_width < 1280
      return "<font color=\'red\'>#{episode.original_width}x#{episode.original_height}</font>"
    else
      "#{episode.original_width}x#{episode.original_height}"
    end
  end

  def remote_ip
    forwarded = request.env["HTTP_X_FORWARDED_FOR"]
    addr = request.env["REMOTE_ADDR"]
    if forwarded
      forwarded.split(",").first
    elsif addr
      addr
    end
  end

  # Sends the initial values of the known feature flags to the Redux store.
  def initial_rox_flags
    result = {}
    FeatureFlags::ALL_FLAGS.collect do |flag_name|
      result[flag_name] = FeatureFlags.instance.send(flag_name.to_sym).enabled?
    end
    puts "initial_rox_flags #{result}"
    return result
  end

end
