class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :messages

  def self.get(sender_name, recipient_name)
    where(
      sender_name: sender_name,
      recipient_name: recipient_name
    ).or(
      where(sender_name: recipient_name,
            recipient_name: sender_name)
    ).first
  end

  def self.for_user(user)
    where(sender: user).or(where(recipient: user))
  end

  def opposed(user)
    sender == user ? recipient : sender
  end
end
