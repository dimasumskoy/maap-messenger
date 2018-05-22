class Message < ApplicationRecord
  attr_encrypted :body, type: :string, random_iv: true

  belongs_to :user
  belongs_to :conversation, touch: true

  validates :encrypted_body, symmetric_encryption: true
  validates :body, presence: true

  scope :portion, ->(range, iteration) {
    least_id = includes(:conversation).last(range * iteration).min.id
    includes(:conversation).where(['id < ?', least_id]).last(range)
  }
end
