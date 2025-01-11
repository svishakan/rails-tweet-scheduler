Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # Root route
  root to: "main#index" # Same as "get '/'" or "get ''"

  # GET /about-us (name of the route is "about")
  get "about-us", to: "about#index", as: :about

  # GET shows the form ("new"), POST creates the record ("create")
  get "sign-up", to: "registrations#new"
  post "sign-up", to: "registrations#create"
  get "sign-in", to: "sessions#new"
  post "sign-in", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"
end
