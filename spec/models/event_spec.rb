require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:event)  { create :event }

  let(:other_user) {create(:user, first_name: "New", last_name: "User", confirmed_at: Time.now)}



  context "pre existing event" do

    describe "event#invite_the_user" do
      it "adds a new user to event.users " do
        event.invite_the_user(other_user.email, event)
        expect(event.users.last).to eq(other_user)
      end

      it "assigns new user's role as \"invited\" " do
        event.invite_the_user(other_user.email, event)
        expect(other_user.event_role(event.id)).to eq("invited")
      end

      it "assigns new user's status as \"accepted\" " do
        event.invite_the_user(other_user.email, event)
        expect(other_user.event_status(event.id)).to eq("pending")
      end
    end
  end

    describe "event#update_user_role" do
      before do
        EventUserRole.create!(user_id: other_user.id, event_id: event.id, role: 0, status: 1)
      end
      it "changes user's role to admin" do
        event.update_user_role(other_user.id)
        expect(other_user.event_role(event.id)).to eq("admin")
      end
    end


      describe "event#all_conversations"  do
        it "returns all conversations associated with the event" do
          result = event.all_conversations(event)
          expect(result).to eq(event.conversations)
        end
      end

end
