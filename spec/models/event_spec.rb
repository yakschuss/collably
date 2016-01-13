require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:event)  { create :event }
  let(:user) {create(:user, confirmed_at: Time.now)}

  it {should belong_to(:user)}
  it { should validate_presence_of(:title)}
  it { should validate_length_of(:title).is_at_least(5)}


    describe "attributes" do
      it "should respond to title" do
        expect(event).to respond_to(:title)
      end
    end
end
