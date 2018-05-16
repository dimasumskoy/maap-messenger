class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  respond_to :json

  def index
    respond_with(@users = User.all)
  end

  def show
    respond_with(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
