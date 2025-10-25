Rails.application.routes.draw do
  devise_for :users
  resources :shelves do
    resources :items, only: [:create, :show, :edit, :update, :destroy]
  end
  get 'pages/home'

  devise_scope :user do
    #一時的なGET対応のログアウトルート
    #get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "pages#home"
end
