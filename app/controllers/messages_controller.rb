class MessagesController < ApplicationController
  before_action :set_conversation
  before_action :set_portion_params, only: [:messages_portion]

  respond_to :json, only: :messages_portion

  def create
    @message = @conversation.messages.create(message_params.merge(user: current_user))
  end

  def messages_portion
    respond_with(@messages = @conversation.messages.portion(@conversation_id, @range, @iteration))
  end

  private

  def set_portion_params
    @conversation_id = params[:conversation_id]
    @range = params[:range].to_i
    @iteration = params[:iteration].to_i
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
