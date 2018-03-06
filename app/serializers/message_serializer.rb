class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :user_id, :conversation_id, :user_username

  belongs_to :user
  belongs_to :conversation

  def user_username
    object.user.username
  end
end
