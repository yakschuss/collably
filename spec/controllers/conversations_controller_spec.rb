require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
let(:my_user) {create :user}
let(:second_user) {create :user, first_name: "Joe", last_name: "Jackson", email: "joe@joe.com"}
let!(:conversation){my_user.mailbox.conversations.create!(subject: "HI Joe")}

    context "authorized user manipulating messages" do
        before do
            sign_in my_user
        end
        describe "POST create" do
            it "uses mailboxer to create a conversation using the parameters given" do
                expect {post :create, conversation: {recipients:[second_user.id], subject: "im adding params", body: "im adding params"}}.to change(my_user.mailbox.conversations,:count).by(1)
            end

            it "redirects to conversation path" do
                post :create, conversation: {recipients:[second_user.id], subject: "im adding params", body: "im adding params"}
                expect(response).to redirect_to conversation_path(my_user.mailbox.conversations.last.id)
            end
        end

        describe "GET show" do
            before do
                sign_in my_user
            end
            it "returns all messages for user" do
                Rails.logger.info "----------------------=--------=------#{conversation.inspect}"
                Rails.logger.info "----------------------=--------=------#{conversation.participants.inspect}"
                get :show, id: conversation.id
                expect(assigns(:receipts)).to(conversation.receipts_for(my_user))
            end
        end

        describe "POST reply" do

        end

        describe "POST trash" do

        end

        describe "POST untrash" do

        end
    end
end
#"conversation"=>{"recipients"=>["", "5"], "subject"=>"Checking create conversation variable", "body"=>"check"}, "commit"=>"Send Message"}
