Rails.application.routes.draw do
  get 'settings/index'
  devise_for :users

  resources :shelves do
    resources :items, only: [:new, :create, :show, :edit, :update, :destroy]
  end

  # 設定ページ（仮）
  get "settings", to: "settings#index"

  authenticated :user do
    root to: "shelves#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#home", as: :unauthenticated_root
  end
end
