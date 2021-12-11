Rails.application.routes.draw do
  health_check_routes

  resources :users
  resources :experiences
  post 'login', to: 'authentication#login'
  get 'version', to: 'application#show_version'
  get 'account', to: 'application#account'

  get '/user/:id/experiences/', to: 'experiences#find_by_user_id'
end
