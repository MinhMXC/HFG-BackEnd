Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: "overrides/sessions",
    registrations: "overrides/registrations"
  }


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, :activities

  resources :applications, only: [:create]
  delete "applications", to: "applications#destroy"

  resources :attendances, only: [:create]
  delete "attendances", to: "attendances#destroy"
  post "attendances/mark", to: "attendances#mark"
  post "attendances/unmark", to: "attendances#unmark"
end