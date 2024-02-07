Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: "overrides/sessions",
    registrations: "overrides/registrations"
  }


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, :activities

  get "user/:id/applications", to: "applications#show_user"
  get "activity/:id/applications", to: "applications#show_activity"
  post "activity/:id/applications", to: "applications#create"
  delete "activity/:id/applications", to: "applications#destroy"

  get "user/:id/attendances", to: "attendances#show_user"
  get "activity/:id/attendances", to: "attendances#show_activity"
  post "activity/:id/attendances", to: "attendances#create"
  post "activity/:id/attendances/delete", to: "attendances#destroy"
  post "activity/:id/attendances/mark", to: "attendances#mark"
  post "activity/:id/attendances/unmark", to: "attendances#unmark"

  get "/current_user", to: "users#show_simple"
end
