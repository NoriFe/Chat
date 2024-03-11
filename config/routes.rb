Rails.application.routes.draw do
  resources :rooms do
    resources :messages
  end
    devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    registration: 'admin/registration'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'pages#home'
  get 'pages/users'
  get 'pages/admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'user/:id', to: 'user#show', as: 'user'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
