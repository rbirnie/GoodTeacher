class CommentsController < ApplicationController

  before_filter :load_commentable
  
  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @user = User.find(params[:user_id])
    @comment = @commentable.comments.new(params[:comment])
    @comment.commenter = current_user
    if @comment.save
      redirect_to :back
    else
      render :new
    end
  end

private

  def load_commentable
    klass = [Unit, Course, Lesson, Assessment, VocabularyList].detect { |c| params["#{c.name.underscore}_id"] }
    if klass.blank?
      klass = [User].detect { |c| params["#{c.name.underscore}_id"] }
    end
    @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

end
