class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation, touch: true

  validates :body, presence: true

  scope :portion, ->(conversation_id, range, iteration) {
    conversation = Conversation.find(conversation_id)
    least_message_id = conversation.messages.least_message_id(range * iteration)
    conversation.messages.where(['id < ?', least_message_id]).last(range)
  }

  scope :least_message_id, ->(range) { ids[-(range)..-1].min }
end
