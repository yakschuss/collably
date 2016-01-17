class EventUserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  after_create :assign_user_role

  enum role: [:member, :admin]

#  private
#  def assign_user_role

#  end
end
