require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:event)  { create :event }
  let(:user) {create(:user, confirmed_at: Time.now)}






    describe "attributes" do
      it "should respond to title" do
        expect(event).to respond_to(:title)
      end
    end
end
