class AddNamesToConversations < ActiveRecord::Migration[5.1]
  def change
    add_column :conversations, :sender_name, :string
    add_column :conversations, :recipient_name, :string
  end
end
