class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

    has_many :roles, class_name: "EventUserRole"
    has_many :events, through: :roles#, conditions: {status: 'accepted'}
  #  has_many :pending_events, through: :event_user_roles, source: :event#, conditions: {status: 'pending'} accepts_nested_attributes_for :events

    def role(event_id)
      query = EventUserRole.where(event_id: event_id, user_id: self.id).take
      query ? query.role : "none"
    end

    def status(event_id)
      query = EventUserRole.where(event_id: event_id, user_id: self.id).take
      query ? query.status : "none"
    end

    def full_name
      return "#{self.first_name} #{self.last_name}"
    end

    def turn_down_invite(event_id)
      invitation = EventUserRole.where(event_id: event_id, user_id: self.id).take
        invitation ? invitation.delete : "no such event"
    end

    def accept_the_invite(event_id)
      invitation = EventUserRole.where(event_id: event_id, user_id: self.id).take
      if invitation
       invitation.status = :accepted
       invitation.role = :member

      invitation.save!
      else
       "no such event"
      end
    end
end
