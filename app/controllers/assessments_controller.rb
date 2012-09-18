class AssessmentsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @assessments = @user.assessments.paginate(page: params[:page])
    @title = "My Assessments"
  end
  

  def show
    @user = User.find(params[:user_id])
    @assessment = @user.assessments.find(params[:id])
    @title = @assessment.name
    @commentable = Assessment.find(params[:id])
    @comments = @commentable.comments
    @comment = Comment.new
    @favorable = @assessment
    @favorite = Favorite.new
  end

  def new
    @title = "New Assessment"
    @user = User.find(params[:user_id])
    @unit = @user.units.find(params[:unit_id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_assessments_path(@user)
    end
    @assessment = @unit.assessments.build
  end

  def create
    @user = User.find(params[:user_id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_assessments_path(@user)
    else
      @unit = @user.units.find(params[:unit_id])
      @assessment = Assessment.new(params[:assessment])
      @assessment.user_id = current_user.id
      @unit.assessments << @assessment
      @unit.save
    end
    if @unit.save
      redirect_to user_assessment_path(@user, @assessment), notice: "Successfully created assessment."
    else
      render :action => :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @assessment = @user.assessments.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_assessment_path(@user, @assessment)
    end
  end

  def update
    @user = User.find(params[:user_id])
    @assessment = @user.assessments.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_assessments_path(@user, @assessment)
    else
      if @assessment.update_attributes(params[:assessment])
        redirect_to user_assessment_path(@user, @assessment), notice: "Successfully updated assessment."
      else
        render :edit
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_assessments_path(@user)
    else
      @assessment = current_user.assessment.find(params[:id])
      @assessment.destroy
      redirect_to user_assessments_path(@user), notice: "Successfully destroyed assessment"
    end
  end
end