class Conversation::MessagesController < ApplicationController
  before_action :set_conversation

  def get_portion
    @messages = @conversation.messages.portion(params[:range].to_i, params[:iteration].to_i)
    render json: @messages
  end

  def expand
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end