Rails.application.routes.draw do
  resources :posts

  mount MissionControl::Web::Engine => "/mission_control-web"
end
