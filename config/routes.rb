MissionControl::Web::Engine.routes.draw do
  resources :routes, only: [ :index ]
end
