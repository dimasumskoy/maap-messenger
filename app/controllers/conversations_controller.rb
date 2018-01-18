class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show]

  def index
    @conversations = current_user.conversations
  end

  def show
    if @conversation.present?
      @sender_name    = @conversation.sender_name
      @recipient_name = @conversation.recipient_name
    else
      create
    end
  end

  def create
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
end
