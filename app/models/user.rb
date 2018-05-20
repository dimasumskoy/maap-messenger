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
  validates :username, uniqueness: { case_sensitive: false }

  before_validation { |record| record.username ||= "@#{self.name.underscore.gsub(/\s+/, '')}" }
  after_save ThinkingSphinx::RealTime.callback_for(:user)

  def contacts
    contacts = []
    conversations.find_each { |c| contacts << c.opposed(self) }
    contacts
  end

  def owner_of?(message)
    id == message.user_id
  end
end
