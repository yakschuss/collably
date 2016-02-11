Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: 'registrations', omniauth_callbacks: "callbacks"}

  root to: 'welcome#index'
end
