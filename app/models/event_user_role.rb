class EventUserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  after_initialize :default_attributes

  validates :user_id, uniqueness: { scope: :event_id }
  
  PENDING_STATUS = 0
  ACCEPTED_STATUS = 1


  enum role: [:member, :admin, :invited]
  enum status: [:pending, :accepted]


  private
    def default_attributes
        self.role ||= :invited
        self.status ||= :pending
    end






end
