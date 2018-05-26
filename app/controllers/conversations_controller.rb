class ConversationsController < ApplicationController
  before_action :set_conversation, :save_current_user, :set_range, only: [:show]

  def index
    respond_with(@conversations = Conversation.for_user(current_user))
  end

  def show
    @messages    = @conversation.messages.ordered
    @new_message = @conversation.messages.new
  end

  def create
    respond_with(
      @conversation = Conversation.find_or_create(current_user.id, params[:user_id]),
      location: me_conversation_path(@conversation, user_name: @conversation.opposed(current_user).username)
    )
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def set_range
    @range = @conversation.standard_range
  end

  def save_current_user
    gon.current_user = current_user if current_user
  end
end
