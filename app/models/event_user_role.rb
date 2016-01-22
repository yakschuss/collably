class EventUserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  after_initialize :default_role

  enum role: [:member, :admin, :invited]

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
    def default_role
        self.role ||= :invited
Rails.logger.info "***EURmodel***assign_user_role #{self.role.inspect}"
    end




end
