class AddIndexesToUserAttributes < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
