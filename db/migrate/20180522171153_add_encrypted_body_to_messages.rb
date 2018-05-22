class AddEncryptedBodyToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :encrypted_body, :text, null: false
  end
end
