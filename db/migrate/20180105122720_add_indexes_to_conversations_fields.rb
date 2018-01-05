class AddIndexesToConversationsFields < ActiveRecord::Migration[5.1]
  def change
    change_column :conversations, :sender_id, :integer, index: true
    change_column :conversations, :recipient_id, :integer, index: true
    add_index :conversations, [:sender_id, :recipient_id], unique: true
  end
end
