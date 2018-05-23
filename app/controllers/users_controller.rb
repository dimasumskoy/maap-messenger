class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  respond_to :json

  def index
    @contacts = Conversation.for_user(current_user).map { |c| c.opposed(current_user) }
  end

  def show
  end

  def edit
  end

  def update
    respond_with(@user.update(user_params), location: @user)
  end

  def destroy
    respond_with(@user.destroy, location: new_user_session_path)
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :phone, :bio)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
