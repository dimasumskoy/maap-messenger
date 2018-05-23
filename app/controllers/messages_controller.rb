class MessagesController < ApplicationController
  before_action :set_conversation
  after_action  :stream_message, only: [:create]

  def create
    @message = @conversation.messages.create(message_params.merge(user: current_user))
    if @message.save
      render json: @message
    else
      render json: @message, status: 422, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body, :encrypted_body, :conversation_id)
  end

  def stream_message
    return if @message.errors.any?
    MessagesChannel.broadcast_to @conversation,
      MessageSerializer.new(@message).to_json
  end
end
