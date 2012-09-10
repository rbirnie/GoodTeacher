class UsersController < ApplicationController
  respond_to :html

  def index
    @users = User.all
    @title = "All Users"
  end

  def show
    @user = User.find(params[:id])
    @title = "#{@user.name} - #{@user.school}"
  end

  def edit
    @user = User.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to @user
    end
    @title = "Edit your Profile"
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      @user.update_attributes(params[:user])
      respond_with @user
    else
      flash[:error] = "Failed"
      redirect_to @user
    end
  end

end
