Rails.application.routes.draw do


  devise_for :users, controllers: {registrations: 'registrations'}
  resources :events
  resources :users, only: :show
  root to: 'welcome#index'
end
