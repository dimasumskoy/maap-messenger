class MessageSerializer < ActiveModel::Serializer
  attributes :id,
             :body,
             :user_id,
             :conversation_id,
             :user_username,
             :created_time,
             :created_date

  belongs_to :user
  belongs_to :conversation

  def user_username
    object.user.username
  end

  def created_time
    object.created_at.strftime("%H:%M:%S")
  end

  def created_date
    object.created_at.strftime("%d.%m.%Y")
  end
end
