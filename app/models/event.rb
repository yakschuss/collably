class Event < ActiveRecord::Base
  has_many :roles, class_name: "EventUserRole"
  has_many :users, through: :roles

  validates :title, length: {minimum: 5}, presence: true

  #scope :admin, -> { where(roles: 'admin') }
  #scope :members, -> {where(roles: 'member')}




  def invite_the_user(user_email, event)

    begin
      invited_user = User.find_by(email: user_email)
      event.users << invited_user
      event_user =  EventUserRole.find_by(user_id: "#{invited_user.id}", event_id: event.id)
      event_user.role ||= :invited
      event_user.status ||= 0
      true
    rescue StandardError => e
      false
    end
  end

  def update_user_role(user_id)
    member = EventUserRole.where(event_id: self.id, user_id: user_id).take
    member.update(role: "admin")
  end



end
