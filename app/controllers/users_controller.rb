class UsersController < ApplicationController

  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  def following
  end
  def followers
  end
end
