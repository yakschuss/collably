Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: 'registrations'}
  resources :events
  root to: 'welcome#index'
end
