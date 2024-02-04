Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: "overrides/sessions",
    registrations: "overrides/registrations"
  }


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, :activities

  get "applications/activity/:id", to: "applications#show"
  post "applications/activity/:id", to: "applications#create"
  delete "applications/activity/:id", to: "applications#destroy"

  get "attendances/activity/:id", to: "attendances#show"
  post "attendances/activity/:id", to: "attendances#create"
  post "attendances/activity/:id/delete", to: "attendances#destroy"
  post "attendances/activity/:id/mark", to: "attendances#mark"
  post "attendances/activity/:id/unmark", to: "attendances#unmark"

  get "/current_user", to: "users#show_simple"
end
