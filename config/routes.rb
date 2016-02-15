Rails.application.routes.draw do


  devise_for :users, controllers: {registrations: 'registrations'}
  resources :events do
    member do
      post :invite_user, as: "invite_user"
      post :update_user, as: "update_user"
    end
  end

  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
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
