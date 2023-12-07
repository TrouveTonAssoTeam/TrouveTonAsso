Rails.application.routes.draw do
  get 'association_profiles/show'
  get 'association_profiles/edit'
  get 'association_profiles/update'
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

  #Other pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :associations, only: [:index, :show, :edit, :update]
  get 'dashboard', to: 'associations#dashboard'
  #get "association/test", to: "associations#test"
  #post "association/new", to: "associations#new", as: :new_association


  # Profile page and edit
  get 'profil', to: 'profil#show', as: 'profil'
  scope '/profil'  do
  get 'edit', to: 'profil#edit', as: 'profil_edit'
  post 'update', to: 'profil#update', as: 'profil_update'
  # Defines the root path route ("/")
  # root "posts#index"
end
end
