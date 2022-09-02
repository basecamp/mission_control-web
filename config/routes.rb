MissionControl::Web::Engine.routes.draw do
  resources :applications, only: [] do
    resources :routes
  end

  resource :current_application

  root to: "routes#index"
end
