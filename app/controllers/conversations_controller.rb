class ConversationsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if current_user
      @conversations = Conversation.for_user(current_user)
    else
      redirect_to new_user_session_path
    end
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
