Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :associations, path: 'associations', controllers: {
    sessions: 'associations/sessions',
    registrations: 'associations/registrations'
  }

  root 'pages#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :associations, only: [:show]
  get "association/test", to: "associations#test"
  post "association/new", to: "associations#new", as: :new_association

  # Defines the root path route ("/")
  # root "posts#index"
end
