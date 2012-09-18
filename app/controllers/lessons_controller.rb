class LessonsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @lessons = @user.lessons.paginate(page: params[:page])
    @title = "My Lessons"
  end
  

  def show
    @user = User.find(params[:user_id])
    @lesson = @user.lessons.find(params[:id])
    @title = @lesson.name
    @commentable = Lesson.find(params[:id])
    @comments = @commentable.comments
    @comment = Comment.new
    @favorable = @lesson
    if @lesson.favorites.where(favorer: current_user).first
      @favorite = @lesson.favorites.where(favorer: current_user).first
    else
      @favorite = Favorite.new
    end
  end

  def new
    @title = "New Lesson"
    @user = User.find(params[:user_id])
    @unit = @user.units.find(params[:unit_id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_lessons_path(@user)
    end
    @lesson = @unit.lessons.build
  end

  def create
    @user = User.find(params[:user_id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_lessons_path(@user)
    else
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
  end

  def edit
    @user = User.find(params[:user_id])
    @lesson = @user.lessons.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_lesson_path(@user, @lesson)
    end
  end

  def update
    @user = User.find(params[:user_id])
    @lesson = @user.lessons.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_lesson_path(@user, @lesson)
    else
      if @lesson.update_attributes(params[:lesson])
        redirect_to user_lesson_path(@user, @lesson), notice: "Successfully updated lesson."
      else
        render :edit
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @lesson = current_user.lesson.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_lesson_path(@user, @lesson)
    else
      @lesson.destroy
      redirect_to lessons_url, notice: "Successfully destroyed lesson"
    end
  end
end