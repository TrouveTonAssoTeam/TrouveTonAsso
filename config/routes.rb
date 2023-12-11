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
  post 'like/:organisation_id', to: 'like#like', as: "like_asso"
  post 'unlike/:organisation_id', to: 'like#unlike', as: "unlike_asso"

  # Organisations routes with edit pages, donations, promoted
  resources :organisations, only: [:index, :show, :edit, :update] do
    collection do
      get "test"
      post "new", as: "new"
      get "dashboard"

    end
    resources :promoted, only: [:index, :new] do
      collection do
        get "success", to: "promoted#success", as: "success"
        get "cancel", to: "promoted#cancel", as: "cancel"
        post "go_to_paiement", to: "promoted#go_to_paiement", as: "go_to_paiement"
      end
    end
    get "donate", to: "donations#new", as: "new_donation"

    resources :faqs, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  resources :payments, only: [:new, :create]
  get 'payments/success', to: 'payments#success', as: 'payment_success'
  get 'payments/cancel', to: 'payments#cancel', as: 'payment_cancel'

  # Profile page and routes associated
  resources :profil, only: [:index, :edit, :update] do
    get "donations", to: "donations#user_donations", as: "user_donations"
    get "likes", to: "like#user_likes", as: "user_likes"
  end

  # Set the dyslexie mode
  post 'dyslexie/:value', to: 'application#set_dyslexie', as: 'set_dyslexie'
  
end