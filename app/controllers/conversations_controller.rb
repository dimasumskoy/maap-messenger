class ConversationsController < ApplicationController
  before_action :set_messages_range, only: [:show]

  def index
    @conversations = Conversation.for_user(current_user)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages     = @conversation.messages.size > @range ? @conversation.messages.last(@range) : @conversation.messages
  end

  def create
    @conversation = Conversation.find_or_create(current_user.id, params[:user_id])
    redirect_to @conversation
  end

  private

  def set_messages_range
    @range = 20
  end
end
