Rails.application.routes.draw do
  # Devise for users and organisations
  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_for :organisations, path: 'organisations', controllers: {
    sessions: 'organisations/sessions',
    registrations: 'organisations/registrations',
    passwords: 'organisations/passwords'
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

  # for events
  resources :events
  get '/events/:id/attend', to: 'events#attend', as: 'attend_event'
  delete '/events/:id/unattend', to: 'events#unattend', as: 'unattend_event'

  # For likes
  post 'like/:organisation_id', to: 'like#like', as: "like_asso"
  post 'unlike/:organisation_id', to: 'like#unlike', as: "unlike_asso"

  # Organisations routes with edit pages, donations, promoted
  resources :organisations, only: [:index, :show, :edit, :update] do
    collection do
      get "test"
      post "new", as: "new"
      get "dashboard"
      get "dashboard/faqs/:faq_id/answer", to: "faqs#new_answer", as: "answer_faq"
      post "dashboard/faqs/:faq_id/answer", to: "faqs#create_answer", as: "create_answer"
    end
    resources :faqs, only: [:new, :create]
    resources :promoted, only: [:index, :new] do
      collection do
        get "success", to: "promoted#success", as: "success"
        get "cancel", to: "promoted#cancel", as: "cancel"
        post "go_to_paiement", to: "promoted#go_to_paiement", as: "go_to_paiement"
      end
    end
    get "donate", to: "donations#new", as: "new_donation"
  end

  get '/tips/all_tips', to: 'tips#all_tips', as: 'all_tips'

  resources :organisations, only: [:index, :show, :edit, :update] 
  get "organisation/test", to: "organisations#test"
  post "organisation/new", to: "organisations#new", as: :new_organisation

  resources :cagnottes, only: [:show] do
    member do
      get :withdrawal
      post :process_withdrawal
    end
  end 

  resources :withdrawals, only: [:index] do
    collection do
      get :admin_withdraw
    end
      member do
        get :show_admin
        patch :update_status
      end
  end

  resources :donations, except: [:show]

  resources :payments, except: [:show]
  resources :payments, only: [:new, :create]
  
  get 'payments/success', to: 'payments#success', as: 'payment_success'
  get 'payments/cancel', to: 'payments#cancel', as: 'payment_cancel'

  # Profile page and routes associated
  resources :profil, only: [:index, :edit, :update]

  # Set the dyslexie mode
  post 'dyslexie/:value', to: 'application#set_dyslexie', as: 'set_dyslexie'
  
end