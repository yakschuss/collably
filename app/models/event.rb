class Event < ActiveRecord::Base
  has_many :roles, class_name: "EventUserRole"
  has_many :users, through: :roles

  validates :title, length: {minimum: 5}, presence: true

  #scope :admin, -> { where(roles: 'admin') }
  #scope :members, -> {where(roles: 'member')}




def invite_user(user_email)
    email = user_email #.to_s
    invited_user = User.find_by(email: "#{email}")
    if invited_user
      self.users << invited_user
      user =  EventUserRole.find_by(user_id: "#{invited_user.id}", event_id: self.id)
      user.role ||= :invited
      user.invited_at = Time.now
    else
      #devise_invitable
    end
end

end
