Rails.application.routes.draw do
  
  devise_for :associations
  devise_for :users
  root 'pages#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :associations

  # Profile page and edit
  get 'profil', to: 'profil#show', as: 'profil'
  scope '/profil'  do
    get 'edit', to: 'profil#edit', as: 'profil_edit'
    post 'update', to: 'profil#update', as: 'profil_update'
  # Defines the root path route ("/")
  # root "posts#index"
end
end
