class Event < ActiveRecord::Base
  has_many :roles, class_name: "EventUserRole"
  has_many :users, through: :roles

  validates :title, length: {minimum: 5}, presence: true

#  scope :administrators, -> {where(roles: :admin)}
#  scope :members, -> {where(roles: :member)}

#  def administrators
#    where
#  end

end
