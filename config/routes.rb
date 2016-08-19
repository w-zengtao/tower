Rails.application.routes.draw do

  resources :teams, only: [:create, :new, :show, :index]
  resources :events, only: [:index]
  resources :members, only: [:create]
  resources :projects, only: [:index, :show]

  root 'events#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
