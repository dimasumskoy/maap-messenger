class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :username
      t.integer :conversations_amount
      t.boolean "admin", default: false

      t.timestamps
    end
  end
end
