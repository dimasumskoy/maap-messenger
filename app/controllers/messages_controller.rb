class MessagesController < ApplicationController
  before_action :set_conversation

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
    params.require(:message).permit(:body)
  end
end
