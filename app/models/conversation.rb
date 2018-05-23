class Conversation < ApplicationRecord
  attr_reader :standard_range

  after_initialize { @standard_range = 20 }

  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :messages

  validates :sender_id, :recipient_id, presence: true
  validates :sender_id, uniqueness: { scope: :recipient_id }

  scope :between, ->(sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  class << self
    def find_or_create(sender_id, recipient_id)
      conversation = between(sender_id, recipient_id).first
      return conversation if conversation

      create!(sender_id: sender_id, recipient_id: recipient_id)
    end

    def for_user(user)
      where(sender: user).or(where(recipient: user))
    end
  end

  def opposed(user)
    sender == user ? recipient : sender
  end

  def messages_greater_than?(amount)
    return true if messages.size > amount
    false
  end
end
