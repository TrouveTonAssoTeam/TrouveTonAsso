Rails.application.routes.draw do
  get 'association_profiles/show'
  get 'association_profiles/edit'
  get 'association_profiles/update'
  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :organisations, path: 'organisations', controllers: {
    sessions: 'organisations/sessions',
    registrations: 'organisations/registrations'
  }

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

  # For likes
  resources :like, only: :index
  post 'like/:organisation_id', to: 'like#like', as: "like_asso"
  post 'unlike/:organisation_id', to: 'like#unlike', as: "unlike_asso"

  resources :organisations, only: [:index, :show, :edit, :update] 
  get "dashboard", to: 'organisations#dashboard'
  get "organisation/test", to: "organisations#test"
  post "organisation/new", to: "organisations#new", as: :new_organisation

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