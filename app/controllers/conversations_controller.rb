class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.for_user(current_user)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = @conversation.messages.new
  end

  def create
    @conversation = Conversation.find_or_create(current_user.id, params[:user_id])
    redirect_to @conversation
  end
end
