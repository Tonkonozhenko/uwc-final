Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'events#index'
  resources :events, only: [:show, :index] do
    resources :tickets, only: [:index, :create]
  end
  resources :tickets, only: [:show]
end
