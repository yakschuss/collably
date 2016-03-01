class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:facebook]

    has_many :roles, class_name: "EventUserRole"
    has_many :events, through: :roles
    has_many :conversations, class_name: "EventUserConversation"

    acts_as_messageable


    def event_role(event_id)
      query = EventUserRole.where(event_id: event_id, user_id: self.id).take
      query ? query.role : "none"
    end

    def event_status(event_id)
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
       invitation.update_attributes(role: "member", status: EventUserRole::ACCEPTED_STATUS)
      else
       "no such event"
      end
    end

    def accepted_events
      events.where("event_user_roles.status = ?", EventUserRole::ACCEPTED_STATUS)
    end

    def pending_events
      events.where("event_user_roles.status = ?", EventUserRole::PENDING_STATUS)
    end

    def mailboxer_name
      self.first_name + " " + self.last_name
    end

    def mailboxer_email(object)
      self.email
    end


    def associated_users
      User.select(:id, :email).joins(:roles).where("event_user_roles.event_id IN (?) AND event_user_roles.user_id != ?", event_ids, self.id)
    end

    def unread_messages?
      array = []
      self.receipts.each do |message|
        array << message.is_unread?
      end
      return array.include?(true)
    end

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user.provider = auth.provider
          user.uid = auth.uid
          user.email = auth.info.email
          user.first_name = auth.info.first_name
          user.last_name = auth.info.last_name
          user.password = Devise.friendly_token[0,20]
          user.skip_confirmation!
          #user.save!
       end
   end

end
