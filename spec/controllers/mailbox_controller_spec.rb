require 'rails_helper'

RSpec.describe MailboxController, type: :controller do
  let(:user) {create :user}

    context "signed in user's inboxes" do
      before(:each)do
        sign_in user
      end
      describe "inbox" do
        it "it assigns @active to mailbox.inbox when it's active" do
          get :inbox
          expect(assigns(:inbox)).to eq(user.mailbox.inbox)
        end
      end

      describe "sentbox" do
        it "displays all sentbox messages when the sentbox mailbox is active." do
          get :sent
          expect(assigns(:sent)).to eq(user.mailbox.sentbox)
      end
    end
      describe "trash" do
        it "displays all trash messages when the trash mailbox is active." do
          get :trash
          expect(assigns(:trash)).to eq(user.mailbox.trash)
      end
    end
  end
end
