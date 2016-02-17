require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  let(:my_user) { create :user }

  let(:second_user) {create(:user, first_name: 'Joe', last_name: 'Jackson', email: 'joe@joe.com')}
  let(:conversation) { my_user.send_message(second_user, "What up", "Hi Joe").conversation }

  context 'authorized user manipulating messages' do
    before do
      sign_in my_user
    end

    describe 'POST create' do
      subject {post :create, conversation: { recipients: [second_user.id], subject: 'im adding params', body: 'im adding params'} }

      it 'uses mailboxer to create a conversation using the parameters given' do
        expect {subject}.to change(my_user.mailbox.conversations, :count).by(1)
      end

      it 'redirects to conversation path' do
        subject
        expected_path = conversation_path(my_user.mailbox.conversations.last.id)
        expect(response).to redirect_to(expected_path)
      end
    end

    describe 'GET show' do
      subject { get :show, id: conversation.id }
      it 'returns all messages for user' do
        subject
        expect(assigns(:receipts)).to eq(conversation.receipts_for(my_user))
      end

      it "marks the conversation read"do
        subject
        expect(conversation.is_read?(my_user)).to eq(true)
      end
    end

    describe 'POST reply' do
    end

    describe 'POST trash' do
    end

    describe 'POST untrash' do
    end
  end
end
