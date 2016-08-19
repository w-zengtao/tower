Rails.application.routes.draw do

  resources :teams, only: [:create, :new, :show]
  resources :events, only: [:index]

  root 'events#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
