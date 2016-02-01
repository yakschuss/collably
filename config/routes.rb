Rails.application.routes.draw do


  devise_for :users, controllers: {registrations: 'registrations'}
  resources :events do
    member do
      post :invite_user, as: "invite_user"
    end
  end

  resources :users, only: [:show] do
    member do
      get :accept_invite
      get :decline_invite
    end
  end
  root to: 'welcome#index'
end
