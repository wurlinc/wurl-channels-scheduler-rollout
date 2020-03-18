WurlChannelsScheduler::Application.routes.draw do

  get 'main', to: 'main#index', :defaults => { :format => 'html' }
  get 'main/:module', to: 'main#index'
  get 'main/:module/:id', to: 'main#index'
  get 'main/:module/:id/:other', to: 'main#index'
  root :to => 'main#index'

  match 'webpack/main-bundle-(:sha).js' => 'application#main_bundle', via: :get, as: :main_bundle


  # If no other matching routes, redirect to main. Protect against abusive requests
  # to unintended paths:
  # TODO: Remove if no issues in production (commited: 2019-06-06)
  unless ENV.fetch('DISABLE_MATCH_STAR_PATH', 'false') == 'true'
    match "*path", to: "main#index", via: :all
  end

end
