class MessagesController < ApplicationController
  before_action :set_conversation

  respond_to :js

  def create
    respond_with(@message = @conversation.messages.create(message_params.merge(user: current_user)))
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
