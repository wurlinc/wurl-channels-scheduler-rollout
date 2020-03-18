require 'kramdown'

class MainController < ApplicationController

  include ReactOnRails::Controller

  before_action :setup_store

  before_action :initialize_shared_store, only: [:index #,
                                                # :client_side_hello_world_shared_store_controller,
                                                # :server_side_hello_world_shared_store_controller
                                                ]

  def index
    @app_props = { name: "Channels Scheduler API" }
    respond_to do |format|
      format.html { return }
      format.json { render json: @app_props }
    end
  end

  def initialize_shared_store
    redux_store("SchedulerStore", props: @scheduler_default_store)
  end


  def setup_store
    # TODO Read store from the DB
    xss_payload = { "xss" => "<script>console.log('Data');</script>" }
    
    puts "feature_flags.rolloutTest.enabled?({}) #{feature_flags.rolloutTest.enabled?({})}"
    redux_model = {
      rox_flag_ruby: feature_flags.rolloutTest.enabled?({})
    }

    # This is the props used by the React component.
    store = redux_model.merge(xss_payload)
    @scheduler_default_store = store

    @react_scheduler_server_props = store
  end

end
