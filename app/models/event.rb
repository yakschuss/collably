class Event < ActiveRecord::Base
  has_many :event_user_roles
  has_many :users, through: :event_user_roles

  validates :title, length: {minimum: 5}, presence: true



end
