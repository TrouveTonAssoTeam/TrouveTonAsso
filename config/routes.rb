Rails.application.routes.draw do
  # Devise for users and organisations
  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :organisations, path: 'organisations', controllers: {
    sessions: 'organisations/sessions',
    registrations: 'organisations/registrations'
  }

  # Root page
  root 'pages#index'

  # static pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'mentionslegales', to: 'pages#mentionslegales'
  get 'cookies', to: 'pages#cookies'
  get 'cgu', to: 'pages#cgu'
  
  # Up check for health
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


  resources :payments, except: [:show]
  get 'payments/success', to: 'payments#success', as: 'payment_success'
  get 'payments/cancel', to: 'payments#cancel', as: 'payment_cancel'

  # Profile page and routes associated
  resources :profil, only: [:index, :edit, :update] do
    get "donations", to: "donations#user_donations", as: "user_donations"
    get "likes", to: "like#user_likes", as: "user_likes"
  end

  # Set the dyslexie mode
  post 'dyslexie/:value', to: 'application#set_dyslexie', as: 'set_dyslexie'

  # Resources for promoted asso
  resources :promoted, only: [:index, :new]
  post 'promoted/go_to_paiement', to: 'promoted#go_to_paiement', as: 'promoted_go_to_paiement'
  get 'promoted/success', to: 'promoted#paiement_success', as: 'promoted_success'
  get 'promoted/cancel', to: 'promoted#paiement_cancel', as: 'promoted_cancel'
  
end