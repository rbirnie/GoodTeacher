class UnitsController < ApplicationController
  respond_to :html

  def index
    @title = "My units"
    @units = current_user.units.all
  end
  

  def show
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
    @title = "New unit"
    @unit = current_user.units.new
  end

  def create
    @unit = current_user.units.new(params[:unit])
    if @unit.save
      redirect_to @unit, notice: "Successfully created unit."
    else
      render :new
    end
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def update
    @unit = Unit.find(params[:id])
    if @unit.update_attributes(params[:unit])
      redirect_to @unit, notice: "Successfully updated unit."
    else
      render :edit
    end
  end

  def destroy
    @unit = current_user.unit.find(params[:id])
    @unit.destroy
    redirect_to units_url, notice: "Successfully destroyed unit"
  end
end
