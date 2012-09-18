class UnitsController < ApplicationController
  respond_to :html

  def index
    @user = User.find(params[:user_id])
    @title = "My units"
    @units = @user.units.paginate(page: params[:page])
  end
  

  def show
    @user = User.find(params[:user_id])
    @unit = Unit.find(params[:id])
    @title = @unit.name
    @commentable = @unit
    @comments = @commentable.comments
    @comment = Comment.new
    @favorable = @unit
    if @unit.favorites.where(favorer: current_user).first
      @favorite = @unit.favorites.where(favorer: current_user).first
    else
      @favorite = Favorite.new
    end

    @lesson = Lesson.new
    @lessons = @unit.lessons.paginate(page: params[:page]).per_page(5)
    @assessment = Assessment.new
    @assessments = @unit.assessments.paginate(page: params[:page]).per_page(5)
    @vocabulary_list = VocabularyList.new
    @vocabulary_lists = @unit.vocabulary_lists.paginate(page: params[:page]).per_page(5)
  end

  def new
    @user = User.find(params[:user_id])
    @title = "New unit"
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_units_path(@user)
    end
    @unit = current_user.units.new
  end

  def create
    @user = User.find(params[:user_id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_units_path(@user)
    else
      @unit = current_user.units.new(params[:unit])
      if @unit.save
        redirect_to user_unit_path(@user, @unit), notice: "Successfully created unit."
      else
        render :new
      end
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @unit = Unit.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_unit_path(@user, @unit)
    end
  end

  def update
    @user = User.find(params[:user_id])
    @unit = Unit.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_unit_path(@user, @unit)
    else
      if @unit.update_attributes(params[:unit])
        redirect_to user_unit_path(@user, @unit), notice: "Successfully updated unit."
      else
        render :edit
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @unit = current_user.unit.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_unit_path(@user, @unit)
    else
      @unit.destroy
      redirect_to user_units_path(@user), notice: "Successfully destroyed unit"
    end
  end
end
