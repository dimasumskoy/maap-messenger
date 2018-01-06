class User < ApplicationRecord
  has_many :conversations, foreign_key: :sender_id
  has_many :messages

  validates :name, presence: true
end
