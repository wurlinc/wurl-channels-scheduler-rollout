# frozen_string_literal: true
require 'csv'
require 'rox/server/rox_server'

JsonFormat = proc { |c| c.request.format == 'application/json' }

# Application controller
class ApplicationController < ActionController::Base
  include ApplicationHelper

  cattr_accessor :rescuing

  helper_method :feature_flags

  before_filter :set_feature_flag_user_info

  rescue_from StandardError, with: :rescue_from_standard_error # unless Rails.env.development?

  def client_offset
    offset = request.headers["HTTP_CLIENT_OFFSET"] ||= 0
    offset.to_i * 60
  end

  def feature_flags
    FeatureFlags.respond_to?(:new) ? FeatureFlags.new : FeatureFlags.instance
  end

  def set_feature_flag_user_info
    Rox::Server::RoxServer.context = {}
  end

  def main_bundle
    # In case the bundle changed since the app initalized, that's a no-op:
    if params[:sha] != ENV.fetch('WEBPACK_BUNDLE_SHA', '') && !Rails.env.development?
      render json: { message: "Can't retreive main-bundle with SHA, #{params[:sha]}." }, status: 422
      return
    end

    path = 'webpack/main-bundle.js'
    unless Dir['public/' + path].empty?
      send_file(Rails.root.join('public', path),
        :content_type =>  'application/javascript',
        :disposition => 'inline',
        :status => 200
      )
    else
      render json: { message: "File not found." }, status: 404
      return
    end
  end

  protected

    def rescue_from_standard_error(exception)
      puts "got error #{exception}"
      # Reenters while rescuing because ExceptionControllers.action(:show) can fail and come back here.
      # Rails.logger.error(exception)
      if @rescuing
        @rescuing = nil
        return
      end
      @rescuing = exception
      # TODO Already doing this on rack? see application.rb config.exceptions_app
      # And it's very bad practice to call one controller from another, but it's the only way it's happening.
      request.env['action_dispatch.exception'] = exception
      begin
        self.class.rescuing = true
        the_response = ExceptionsController.action(:show).call(request.env)
        the_status = the_response[0]
        the_headers = the_response[1]
        body = the_response[2].body()
        response.headers = the_headers
        render body: body, status: the_status, headers: the_headers
        self.class.rescuing = false
      rescue => e
        Rails.logger.error("While handling error #{e.message}")
        Rails.logger.error(e)
      end unless self.class.rescuing
    end

    def rescue_from_not_found(exception)
      respond_to do |format|
        format.html do
          flash[:danger] = "Sorry, could not find #{params['controller'].singularize} #{params[:id]}"
          dest = access_denied_dest request.params

          redirect_to dest
        end
        format.json { head :not_found }
      end
    end

  private

  # See config.consider_all_requests_local in development.rb
  if ENV.fetch('TEST_ERROR_HANDLING', 'false') == 'true'
    def local_request?
      false
    end
  end

end
