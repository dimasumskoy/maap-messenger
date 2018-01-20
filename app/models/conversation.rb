class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :messages

  validates :sender_id, uniqueness: { scope: :recipient_id }

  scope :between, ->(sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  def self.find_or_create(sender_id, recipient_id)
    conversation = between(sender_id, recipient_id).first
    return conversation if conversation

    create(sender_id: sender_id, recipient_id: recipient_id)
  end

  def self.for_user(user)
    where(sender: user).or(where(recipient: user))
  end

  def opposed(user)
    sender == user ? recipient : sender
  end
end
