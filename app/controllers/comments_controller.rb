class CommentsController < ApplicationController

  before_filter :load_commentable
  
  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.commenter = current_user
    if @comment.save
      redirect_to @commentable, notice: "Comment created."
    else
      render :new
    end
  end

private

  #def load_commentable
  #  resource, id = request.path.split('/')[1, 2]
  #  @commentable = resource.singularize.classify.constantize.find(id)
  #end

  # alternative option:
  def load_commentable
    klass = [User, Unit, Course, Lesson].detect { |c| params["#{c.name.underscore}_id"] }
    @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end




#  def new
#    @parent = parent_object
#    @comment = Comment.new
#  end

#  def create
#    @parent = parent_object
#    @comment = Comment.new(params[:comment])
#    @comment.commentor = current_user
#    respond_to do |format|
#      if @comment.save
#        flash[:notice] = 'Comment Saved'
#        redirect_to parent_url(@parent)
#      else
#        redirect_to parent_url(@parent)
#      end
#    end
#  end

#private

#  def parent_object
#    case
#      when params[:user_id] then User.find(params[:user_id])
#    end
#  end

#  def parent_url(parent)
#    case
#      when params[:user_id] then user_path(parent)
#    end
#  end

end
