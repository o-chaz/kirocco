Rails.application.routes.draw do
  devise_for :users

  resources :shelves do
    resources :items, only: [:new, :create, :show, :edit, :update, :destroy]
  end

  # ログイン時と非ログイン時でトップを分ける
  authenticated :user do
    root to: "shelves#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#home", as: :unauthenticated_root
  end
end
