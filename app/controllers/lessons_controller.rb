class LessonsController < ApplicationController


  def index
    @user = User.find(params[:user_id])
    @lessons = @user.lessons
    @title = "My Lessons"
  end
  

  def show
    @user = User.find(params[:user_id])
    @lesson = @user.lessons.find(params[:id])
    @title = @lesson.name
    @commentable = Lesson.find(params[:id])
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @user = User.find(params[:user_id])
    @unit = @user.units.find(params[:unit_id])
    @lesson = @unit.lessons.build

    @title = "New Lesson"
  end

  def create
    @user = User.find(params[:user_id])
    @unit = @user.units.find(params[:unit_id])
    @lesson = Lesson.new(params[:lesson])
    @lesson.user_id = current_user.id
    @unit.lessons << @lesson
    @unit.save
    if @unit.save
      redirect_to user_lesson_path(@user, @lesson), notice: "Successfully created lesson."
    else
      render :action => :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @lesson = @user.lessons.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @lesson = @user.lessons.find(params[:id])
    if @lesson.update_attributes(params[:lesson])
      redirect_to user_lesson_path(@user, @lesson), notice: "Successfully updated lesson."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @lesson = current_user.lesson.find(params[:id])
    @lesson.destroy
    redirect_to lessons_url, notice: "Successfully destroyed lesson"
  end
end

private