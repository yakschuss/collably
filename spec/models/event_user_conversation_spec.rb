require 'rails_helper'

RSpec.describe EventUserConversation, type: :model do

  let(:event) {create :event}
  let(:user) {create :user}

  describe "event_user_conversation#send_message" do
    it "creates a join row conversation for the event" do
      recipients = event.users
      new_convo = EventUserConversation.send_message(event, user, recipients , "hi", "hi")
      expect(event.conversations).to include(new_convo)
    end

    it "creates a join row conversation for the user" do
      recipients = event.users
      new_convo = EventUserConversation.send_message(event, user, recipients , "hi", "hi")
      expect(user.conversations).to include(new_convo)
    end
  end
end
