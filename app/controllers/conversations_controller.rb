class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show]

  def index
    respond_with(@conversations = Conversation.for_user(current_user))
  end

  def show
    @range = 20
    respond_with(@messages = @conversation.messages.size > @range ? @conversation.messages.last(@range) : @conversation.messages)
  end

  def create
    respond_with(@conversation = Conversation.find_or_create(current_user.id, params[:user_id]))
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
end
