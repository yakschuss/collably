class EventUserConversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event


  def self.send_message(event, user, recepients, body, subject)
       conversation = user.send_message(recipients: recipients, body: body, subject: subject).conversation
      EventUserConversation.create!(user_id: user.id, event_id: event.id, conversation_id: conversation.id )
  end
end
