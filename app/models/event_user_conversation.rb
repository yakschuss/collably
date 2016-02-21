class EventUserConversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

   scope :event_messages, -> (event) { EventUserConversation.where(event_id: event.id).pluck("conversation_id")}

  def self.send_message(event, user, recipients, body, subject)
       conversation = user.send_message(recipients, body, subject).conversation
      EventUserConversation.create!(user_id: user.id, event_id: event.id, conversation_id: conversation.id )
  end
end
