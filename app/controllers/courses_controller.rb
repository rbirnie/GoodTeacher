class CoursesController < ApplicationController
  respond_to :html

  def index
    @title = "My Courses"
    @courses = current_user.courses.all
  end
  

  def show
    @course = Course.find(params[:id])
    @title = @course.name
  end

  def new
    @title = "New Course"
    @course = current_user.courses.new
  end

  def create
    @course = current_user.courses.new(params[:course])
    if @course.save
      redirect_to @course, notice: "Successfully created course."
    else
      render :new
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      redirect_to @course, notice: "Successfully updated course."
    else
      render :edit
    end
  end

  def destroy
    @course = current_user.course.find(params[:id])
    @course.destroy
    redirect_to courses_url, notice: "Successfully destroyed course"
  end
end
