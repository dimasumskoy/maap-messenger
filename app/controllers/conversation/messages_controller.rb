class Conversation::MessagesController < ApplicationController
  before_action :set_conversation, :save_user

  def messages_portion
    @messages = @conversation.messages.portion(params[:range].to_i, params[:iteration].to_i)
    render json: @messages
  end

  private

  def save_user
    gon.current_user = current_user if current_user
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end