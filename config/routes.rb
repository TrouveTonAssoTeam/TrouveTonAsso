Rails.application.routes.draw do
  
  devise_for :organisations
  devise_for :users
  root 'pages#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #Other pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'mentionslegales', to: 'pages#mentionslegales'
  get 'cookies', to: 'pages#cookies'
  get 'cgu', to: 'pages#cgu'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :organisations

  resources :donations, except: [:show]

  get 'donations/user_donations', to: 'donations#user_donations', as: 'user_donations'

  resources :payments, except: [:show]
  get 'payments/success', to: 'payments#success', as: 'payment_success'
  get 'payments/cancel', to: 'payments#cancel', as: 'payment_cancel'

  # Profile page and edit
  get 'profil', to: 'profil#show', as: 'profil'
  scope '/profil'  do
    get 'edit', to: 'profil#edit', as: 'profil_edit'
    post 'update', to: 'profil#update', as: 'profil_update'
  end
  # Defines the root path route ("/")
  # root "posts#index"

  # Set the dyslexie mode
  post 'dyslexie/:value', to: 'application#set_dyslexie', as: 'set_dyslexie'
end
