class Event < ActiveRecord::Base
  has_many :roles, class_name: "EventUserRole"
  has_many :users, through: :roles
  has_many :todos
  has_many :conversations, class_name: "EventUserConversation"

  validates :title, length: {minimum: 5}, presence: true





  def invite_the_user(user_email, event_id)

    begin
      invited_user = User.find_by(email: user_email)
      event = Event.find(event_id.id)

      event.users << invited_user

      event_user =  EventUserRole.find_by(user_id: "#{invited_user.id}", event_id: event.id)
      event_user.role ||= :invited
      event_user.status ||= EventUserRole::PENDING_STATUS

       true
    rescue StandardError => e
Rails.logger.info "#{e.inspect}"
       false
    end
  end

  def update_user_role(user_id)
    member = EventUserRole.where(event_id: self.id, user_id: user_id).take
    member.update(role: "admin")
  end

  def all_user_roles(id, role)
    event = Event.find(id)
    event.users.references(:roles).where(event_user_roles: {role: role})
  end

  def all_conversations(event)
      e = Mailboxer::Conversation.where(id: EventUserConversation.event_conversation_ids(event))
      return e
  end


  def admin?(user)
    query = EventUserRole.where(event_id: self.id, user_id: user.id).take
    query.role == "admin" ? true : false
  end

end
