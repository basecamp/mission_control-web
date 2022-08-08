Rails.application.routes.draw do
  mount MissionControl::Web::Engine => "/mission_control-web"

  resources :posts
end
