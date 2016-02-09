require 'rails_helper'

RSpec.describe User, type: :model do
  let(:event) {create(:event)}

    before (:each) do
      @user = event.users.first
    end


    describe "user method #role" do
      it "returns the user role" do
        expect(@user.event_role(event.id)).to eq("invited")
      end
    end

    describe "user method #event_status" do
      it "lists the user's status for a specific event" do
        expect(@user.event_status(event.id)).to eq("pending")
      end
    end

    describe "user method #fullname" do
      it "returns user.first_name and last_name together" do
        expect(@user.full_name).to eq("#{@user.first_name} " + "#{@user.last_name}")
    end
  end


    describe "user method #turn_down_invite" do
      it "deletes the user-event relationship" do
        @user.turn_down_invite(event.id)
        expect(@user.events).to be_empty
      end
    end

    describe "user method #accept_the_invite" do
      it "changes user role to member and status to accepted"do
        @user.accept_the_invite(event.id)
        join = @user.roles.first
        expect(join).to have_attributes(role: "member", status: "accepted")
      end
    end


    describe "all_event_statuses" do
      before(:each) do
        EventUserRole.create!(user_id: @user.id, event_id: 2, role: 0, status: 1)
        EventUserRole.create!(user_id: @user.id, event_id: 3, role: 2, status: 0)
        EventUserRole.create!(user_id: @user.id, event_id: 4, role: 2, status: 0)
      end
      it "returns all event accepted statuses associated with the user" do
      pending
        expect(@user.all_event_statuses(@user.id, "accepted")).to #return event 1 and event 2

      end

      it "returns all event pending statuses associated with the user" do
      pending
       expect(@user.all_event_statuses(@user.id, "pending")).to #return event 3 and event 4

      end
    end
end
