class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation, touch: true

  validates :body, :conversation_id, presence: true

  scope :portion, ->(range, iteration) {
    least_id = includes(:conversation).last(range * iteration).min.id
    includes(:conversation).where(['id < ?', least_id]).last(range)
  }
end
