Rails.application.routes.draw do

  get 'events/new'

  get 'events/create'

  get 'events/show'

  devise_for :users, controllers: {registrations: 'registrations'}
  resources :events
  root to: 'welcome#index'
end
