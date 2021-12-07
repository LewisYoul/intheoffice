Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  devise_scope :user do
    authenticated do
      root 'authenticated/home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'home#index', as: :unauthenticated_root
    end
  end

  scope module: :authenticated do
    resources :account, only: :index
    resources :users, only: %i[new] do
      post :invite, on: :collection # change to user_accounts
    end
    resources :user_accounts, only: %i[index new create edit update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
