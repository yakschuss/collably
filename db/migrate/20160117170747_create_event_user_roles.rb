class CreateEventUserRoles < ActiveRecord::Migration
  def change
    create_table :event_user_roles do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :role

      t.timestamps null: false
    end

    add_index :event_user_roles, :user_id
    add_index :event_user_roles, :event_id

  end
end
