class CreateEventUserConversations < ActiveRecord::Migration
  def change
    create_table :event_user_conversations do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :conversation_id

      t.timestamps null: false
    end
    add_index :event_user_conversations, :user_id
    add_index :event_user_conversations, :event_id

  end
end
