Rails.application.routes.draw do


  devise_for :users, controllers: {registrations: 'registrations', omniauth_callbacks: "callbacks"}
  resources :events do
    resources :todos, only: [:create, :destroy]
    member do
      post :send_message, as: "send_message"
      post :invite_user, as: "invite_user"
      post :update_user, as: "update_user"
    end
  end
  get 'creatives/index'
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  resources :conversations do
    member do
      post :delete_message, controller: "events"
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
  root to: 'creatives#index'
end
