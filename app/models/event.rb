class Event < ActiveRecord::Base
  belongs_to :user

  validates :title, length: {minimum: 5}, presence: true


end
