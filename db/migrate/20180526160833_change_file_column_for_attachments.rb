class ChangeFileColumnForAttachments < ActiveRecord::Migration[5.1]
  def up
    rename_column :attachments, :file, :files
    change_column :attachments, :files, :json, using: 'files::JSON'
  end

  def down
    rename_column :attachments, :files, :file
    change_column :attachments, :file, :string
  end
end
