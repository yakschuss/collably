class CreateEventUserRoles < ActiveRecord::Migration
  def change
    create_table :event_user_roles do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :role, default: 1

      t.timestamps null: false
    end
  end
end
