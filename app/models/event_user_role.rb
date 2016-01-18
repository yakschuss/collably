class EventUserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  before_save :assign_user_role

  enum role: [:member, :admin]

  private
    def assign_user_role
      self.role ||= :member 
    end
end
