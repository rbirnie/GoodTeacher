class CoursesController < ApplicationController
  respond_to :html

  def index
    @user = User.find(params[:user_id])
    @title = "My Courses"
    @courses = @user.courses.all
  end
  

  def show
    @user = User.find(params[:user_id])
    @course = @user.courses.find(params[:id])
    @title = @course.name
    @commentable = @course
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @user = User.find(params[:user_id])
    @title = "New Course"
    @course = current_user.courses.new
  end

  def create
    @user = User.find(params[:user_id])
    @course = @user.courses.new(params[:course])
    if @course.save
      redirect_to user_course_path(@user, @course), notice: "Successfully created course."
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @course = @user.courses.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @course = @user.courses.find(params[:id])
    if @course.update_attributes(params[:course])
      redirect_to user_course_path(@user, @course), notice: "Successfully updated course."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @course = @user.courses.find(params[:id])
    @course.destroy
    redirect_to user_courses_url(@user), notice: "Successfully destroyed course"
  end
end
