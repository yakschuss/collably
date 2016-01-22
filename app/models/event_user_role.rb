class EventUserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  after_initialize :assign_user_role

  enum role: [:member, :admin, :invited]

  private
    def assign_user_role
        self.role ||= :invited
Rails.logger.info "***EURmodel***assign_user_role #{self.role.inspect}"
    end



end
