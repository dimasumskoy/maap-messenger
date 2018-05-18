class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :conversations, foreign_key: :sender_id
  has_many :messages

  validates :name, :username, :email, presence: true

  before_validation { |record| record.username ||= "@#{self.name.underscore.gsub(/\s+/, '')}" }

  def owner_of?(message)
    id == message.user_id
  end
end
