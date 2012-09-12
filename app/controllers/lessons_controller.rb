class LessonsController < ApplicationController


  def index
    @title = "My Lessons"
    @unit = Unit.find(params[:unit_id])
    @lessons = @unit.lessons
  end
  

  def show
    @lesson = Lesson.find(params[:id])
    @title = @lesson.name
    @commentable = @lesson
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @title = "New Lesson"
    @unit = Unit.find(params[:unit_id])
    @lesson = @unit.lessons.build
  end

  def create
    @unit = Unit.find(params[:unit_id])
    @lesson = Lesson.new(params[:lesson])
    @lesson.user_id = current_user
    @unit.lessons << @lesson
    @unit.save
    if @unit.save
      redirect_to @lesson, notice: "Successfully created lesson."
    else
      render :action => :new
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
  end

  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.update_attributes(params[:lesson])
      redirect_to @lesson, notice: "Successfully updated lesson."
    else
      render :edit
    end
  end

  def destroy
    @lesson = current_user.lesson.find(params[:id])
    @lesson.destroy
    redirect_to lessons_url, notice: "Successfully destroyed lesson"
  end
end

private