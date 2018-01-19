class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show]

  def index
    @conversations = Conversation.for_user(current_user)
  end

  def show
    @conversation = Conversation.get(current_user.name, params[:user])
    @message = @conversation.messages.new
  end

  def create
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
end
