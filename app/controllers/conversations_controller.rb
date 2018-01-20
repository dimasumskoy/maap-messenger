class ConversationsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_conversation, only: [:show]

  def index
    if current_user
      @conversations = Conversation.for_user(current_user)
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @conversation = Conversation.get(current_user.name, params[:with])
    @message      = @conversation.messages.new
  end

  def create
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
end
