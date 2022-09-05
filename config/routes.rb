MissionControl::Web::Engine.routes.draw do
  resources :applications, only: [] do
    resources :routes
  end

  root to: "routes#index"
end
