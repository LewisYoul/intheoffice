Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
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
    resources :home do
      post :search, on: :collection
    end
    resources :account, only: :index
    resources :users, only: %i[new] do
      post :invite, on: :collection # change to user_accounts
    end
    resources :user_accounts, only: %i[index new create edit update] do
      resources :user_account_locations, only: %i[new create edit update destroy]
    end
    resources :workplaces, only: %i[index new create edit update destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
