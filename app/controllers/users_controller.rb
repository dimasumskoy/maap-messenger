class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  respond_to :json

  def index
    respond_with(@users = User.all)
  end

  def show
    respond_with(@user)
  end

  def edit
  end

  def update
    respond_with(@user.update(user_params), flash[:notice] = "Success!", location: @user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :phone, :bio)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
