class Message < ApplicationRecord
  attr_encrypted :body, type: :string, random_iv: true

  belongs_to :user
  belongs_to :conversation, touch: true

  validates :body, :encrypted_body, :conversation_id, :user_id, presence: true
  validates :encrypted_body, symmetric_encryption: true

  before_validation :generate_identifier
  after_create_commit :stream_message

  scope :ordered, -> { order(created_at: :asc) }
  scope :portion, ->(range, iteration) {
    least_id = includes(:conversation).last(range * iteration).min.id
    includes(:conversation).where(['id < ?', least_id]).last(range)
  }

  def crop_body_length(length)
    "#{body[0..length]} ..."
  end

  private

  def generate_identifier
    self.identifier ||= loop do
      new_identifier = SecureRandom.hex(5)
      break new_identifier unless self.class.exists?(identifier: new_identifier)
    end
  end

  def stream_message
    return if self.errors.any?
    MessagesChannel.broadcast_to conversation,
      MessageSerializer.new(self).to_json
  end
end
