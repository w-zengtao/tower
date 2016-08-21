Rails.application.routes.draw do

  # WebSite
  resources :teams, only: [:create, :new, :show, :index]
  resources :events, only: [:index]
  resources :members, only: [:create] # 因为有 current_team  这里不设置嵌套路由
  resources :projects, only: [:index, :show, :create, :edit] do
    resources :todos
    scope module: :projects do
      resources :members, only: [:index, :create, :destroy]
    end
  end
  resources :accesses, only: [:create]

  # API
  namespace :api do
    scope module: :v1 do
      resources :events, only: [:index]
    end
  end

  # Root
  root 'events#index'

  # Devise
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

end
