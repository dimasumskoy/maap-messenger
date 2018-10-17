class AddFilesToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :files, :json
  end
end
