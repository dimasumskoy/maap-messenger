class Attachment < ApplicationRecord
  belongs_to :message

  validates :file, presence: true

  mount_uploader :file, AttachmentUploader
end
