class AddStatusToEventUserRoles < ActiveRecord::Migration
  def change
    add_column :event_user_roles, :status, :integer
  end
end
