require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:event)  { create :event }

  let(:other_user) {create(:user, first_name: "New", last_name: "User", confirmed_at: Time.now)}



  context "pre existing event" do
    describe "event#invite_the_user" do
      it "adds a new user to event.users " do
        event.invite_the_user(other_user.email, id: event.id)
Rails.logger.info "#{event.users.inspect}"
        expect(event.users.last).to eq(other_user)
      end
    end
  end


end
