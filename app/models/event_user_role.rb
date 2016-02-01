class EventUserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  after_initialize :default_attributes

  enum role: [:member, :admin, :invited]
  enum status: [:pending, :accepted]

=begin
  def self.make_admin(user)
    event = EventUserRole.find_by(event_id: @event.id)   # may only return the first one, so be careful!
    events.each do |event|
      event.role = admin
      event.save!
    end
  end
=end

  private
    def default_attributes
        self.role ||= :invited
Rails.logger.info "***EURmodel***default attribute - role #{self.role.inspect}"
        self.status ||= :pending
Rails.logger.info "***EURmodel***default attribute - status #{self.status.inspect}"
    end






end
