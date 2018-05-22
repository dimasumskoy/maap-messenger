class ModifyMessagesAttributes < ActiveRecord::Migration[5.1]
  def up
    change_column :messages, :body, :text, null: true
  end

  def down
    change_column :messages, :body, :text
  end
end
