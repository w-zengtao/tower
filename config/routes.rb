Rails.application.routes.draw do

  # TestShallow
  resources :articles do
    resources :titles, shallow: true
  end

  resources :posts, shallow: true do
    resources :authors
  end

  resources :talks do
    resources :dogs
  end


  # WebSite
  resources :teams, only: [:create, :new, :show, :index]
  resources :events, only: [:index]
  resources :members, only: [:create] # 因为有 current_team  这里不设置嵌套路由
  resources :projects, only: [:index, :show, :create, :edit] do
    scope module: :projects do
      resources :todos
      resources :members, only: [:index, :create, :destroy]
    end
  end
  resources :accesses, only: [:create]
  resources :todos, only: [:show] do
    scope module: :todos do
      resources :appoints, only: [:create] # 指派负责人控制器
      resources :comments, only: [:create, :update] # todo 评论控制器
    end
  end
  resources :change_teams, only: [:create]

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
