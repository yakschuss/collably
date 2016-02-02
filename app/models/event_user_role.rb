class EventUserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  after_initialize :assign_user_role

  enum role: [:member, :admin]

  private
    def assign_user_role
      self.role ||= :admin
Rails.logger.info "******assign_user_role #{self.role.inspect}"
    end
end
