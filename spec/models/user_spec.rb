require 'rails_helper'

RSpec.describe User, type: :model do
  let(:event) {create(:event)}
  let(:user) {event.users.first}



    describe "user method #role" do
      it "returns the user role" do
        expect(user.event_role(event.id)).to eq("invited")
      end
    end

    describe "user method #event_status" do
      it "lists the user's status for a specific event" do
        expect(user.event_status(event.id)).to eq("pending")
      end
    end

    describe "user method #fullname" do
      it "returns user.first_name and last_name together" do
        expect(user.full_name).to eq("#{user.first_name} " + "#{user.last_name}")
      end
    end


    describe "user method #turn_down_invite" do
      it "deletes the user-event relationship" do
        user.turn_down_invite(event.id)
        expect(user.events).to be_empty
      end
    end

    describe "user method #accept_the_invite" do
      it "changes user role to member and status to accepted" do
        user.accept_the_invite(event.id)
        join = user.roles.first
        expect(join).to have_attributes(role: "member", status: "accepted")
      end
    end


    context "all_event_statuses" do
        let(:event1) {Event.create!(title: "event1title") }
        let(:event2) {Event.create!(title: "event2title") }
        let(:event3) {Event.create!(title: "event3title") }
        let(:event4) {Event.create!(title: "event4title") }

        before(:each) do
          EventUserRole.create(user: user, event: event1, status: 0)
          EventUserRole.create(user: user, event: event2, status: 0)
          EventUserRole.create(user: user, event: event3, status: 1)
          EventUserRole.create(user: user, event: event4, status: 1)
        end

        it "returns all event accepted statuses associated with the user" do
          expect(user.accepted_events).to match_array([event3, event4])
        end

        it "returns all event pending statuses associated with the user" do
          expect(user.pending_events).to match_array([event1, event2, event])
        end
      end
end
