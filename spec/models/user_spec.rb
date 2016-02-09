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

    describe "user method #fullname" do
      it "returns user.first_name and last_name together" do
        expect(@user.full_name).to eq("#{@user.first_name} " + "#{@user.last_name}")
    end
  end


    describe "user method #turn_down_invite" do
      
      it "gets rid of user-event relationship" do

      end
    end
    describe "user method #accept_the_invite"
    describe "user method #event_status"
    describe "all_event_statuses"
end
