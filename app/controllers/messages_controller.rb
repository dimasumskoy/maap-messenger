class MessagesController < ApplicationController
  before_action :normalize_body
  before_action :set_conversation

  def create
    @message = @conversation.messages.new(message_params.merge(user: current_user))
    respond_to do |format|
      if @message.save
        format.json { render json: @message, status: 200 }
      else
        format.json { render json: @message, status: 422, serializer: ActiveModel::Serializer::ErrorSerializer }
      end
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body, :encrypted_body, :conversation_id)
  end

  def normalize_body
    message_params[:body].strip!
  end
end
