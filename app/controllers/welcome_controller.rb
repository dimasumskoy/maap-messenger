class WelcomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if current_user
      @conversations = Conversation.for_user(current_user)
    else
      redirect_to new_user_session_path
    end
  end
end
