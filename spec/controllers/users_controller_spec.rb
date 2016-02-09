require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:my_user) {create(:user, confirmed_at: Time.now)}
  let(:event_with_user){create(:event)}

  before do
    sign_in my_user
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: my_user.id
      expect(response).to have_http_status(:success)
    end
  end

  context "user deciding to join or leave invite he/she was invited to" do


      let(:join){EventUserRole.create!(user_id: my_user.id, event_id: event_with_user.id, role: 2, status: 0)}


    describe "POST decline_invite", focus: true do
      it "removes the invitation from user.events" do
        
      expect{post :decline_invite, id: event_with_user.id}.to change(my_user.events, :count).by(1)
      end

      it "should return to user#show" do
        post :decline_invite, id: event_with_user.id
        expect(response).to redirect_to(user_path(my_user))
      end
    end

    describe "POST accept_invite"do
      it "changes the user.role to member, and status to accepted" do
        join_row = join
        post :accept_invite, id: event_with_user.id
        join_row.reload
        expect(join_row).to have_attributes(role: "member", status: "accepted")
      end

      it "goes to accepted event page" do
        post :accept_invite, id: event_with_user.id
        expect(response).to redirect_to(event_path(event_with_user.id))
      end
    end
  end

end
