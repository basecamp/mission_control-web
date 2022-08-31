MissionControl::Web::Engine.routes.draw do
  resources :routes

  root to: "routes#index"
end
