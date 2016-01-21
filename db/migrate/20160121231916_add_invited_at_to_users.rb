class AddInvitedAtToUsers < ActiveRecord::Migration
  def change
    add_column :event_user_roles, :invited_at, :datetime
  end
end
