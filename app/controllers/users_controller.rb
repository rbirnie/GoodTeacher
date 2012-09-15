class UsersController < ApplicationController
  respond_to :html

  def index
    @users = User.paginate(page: params[:page])
    @title = "All Users"
  end

  def show
    @user = User.find(params[:id])
    @units = @user.units.paginate(page: params[:page])
    @title = "#{@user.name} - #{@user.school}"
    @commentable = @user
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def edit
    @title = "Edit your Profile"
    @user = User.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to @user
    end
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

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
end
