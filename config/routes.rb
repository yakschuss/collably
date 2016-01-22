Rails.application.routes.draw do


  devise_for :users, controllers: {registrations: 'registrations'}
  resources :events do
    member do
      post :invite_user, as: "invite_user"
    end
  end

  resources :users, only: :show
  root to: 'welcome#index'
end
