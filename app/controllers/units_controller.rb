class UnitsController < ApplicationController
  respond_to :html

  def index
    @user = User.find(params[:user_id])
    @title = "My units"
    @units = current_user.units.all
  end
  

  def show
    @user = User.find(params[:user_id])
    @unit = Unit.find(params[:id])
    @title = @unit.name
    @commentable = @unit
    @comments = @commentable.comments
    @comment = Comment.new
    #@lessons = @unit.lessons
    @lesson = Lesson.new
    @lessons = @unit.lessons
  end

  def new
    @user = User.find(params[:user_id])
    @title = "New unit"
    @unit = current_user.units.new
  end

  def create
    @user = User.find(params[:user_id])
    @unit = current_user.units.new(params[:unit])
    if @unit.save
      redirect_to user_unit_path(@user, @unit), notice: "Successfully created unit."
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @unit = Unit.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @unit = Unit.find(params[:id])
    if @unit.update_attributes(params[:unit])
      redirect_to user_unit_path(@user, @unit), notice: "Successfully updated unit."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @unit = current_user.unit.find(params[:id])
    @unit.destroy
    redirect_to units_url, notice: "Successfully destroyed unit"
  end
end
