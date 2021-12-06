Rails.application.routes.draw do
  health_check_routes

  resources :users
  resources :experiences
  post 'login', to: 'authentication#login'
  get 'version', to: 'application#show_version'
end
