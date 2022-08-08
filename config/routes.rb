MissionControl::Web::Engine.routes.draw do
  resources :routes do
    post "pause", on: :member
  end
end
