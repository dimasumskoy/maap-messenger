class MessageSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::SanitizeHelper
  include MessagesHelper

  attributes :id,
             :body,
             :user_id,
             :conversation_id,
             :user_username,
             :created_time,
             :created_date,
             :markdown_body,
             :path_to_expand,
             :identifier,
             :files

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

  def markdown_body
    markdown(object.body)
  end

  def identifier
    object.identifier
  end

  def path_to_expand
    expanded_message_path(user_name: user_username, identifier: identifier)
  end

  def files
    object.files
  end
end
