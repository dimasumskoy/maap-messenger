class Attachment < ApplicationRecord
  belongs_to :message

  validates :files, presence: true

  mount_uploaders :files, AttachmentUploader
end
