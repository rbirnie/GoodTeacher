class VocabularyListsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @vocabulary_lists = @user.vocabulary_lists.paginate(page: params[:page])
    @title = "My Vocabulary Lists"
  end
  

  def show
    @user = User.find(params[:user_id])
    @vocabulary_list = @user.vocabulary_lists.find(params[:id])
    @title = @vocabulary_list.name
    @commentable = @vocabulary_list
    @comments = @commentable.comments
    @comment = Comment.new
    @favorable = @vocabulary_list
    if @vocabulary_list.favorites.where(favorer: current_user).first
      @favorite = @vocabulary_list.favorites.where(favorer: current_user).first
    else
      @favorite = Favorite.new
    end
  end

  def new
    @title = "New Vocab List"
    @user = User.find(params[:user_id])
    @unit = @user.units.find(params[:unit_id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_vocabulary_lists_path(@user)
    end
    @vocabulary_list = @unit.vocabulary_lists.build
  end

  def create
    @user = User.find(params[:user_id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_vocabulary_lists_path(@user)
    else
      @unit = @user.units.find(params[:unit_id])
      @vocabulary_list = VocabularyList.new(params[:vocabulary_list])
      @vocabulary_list.user_id = current_user.id
      @unit.vocabulary_lists << @vocabulary_list
      @unit.save
    end
    if @unit.save
      redirect_to user_vocabulary_list_path(@user, @vocabulary_list), notice: "Successfully created vocabulary list."
    else
      render :action => :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @vocabulary_list = @user.vocabulary_lists.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_vocabulary_list_path(@user, @vocabulary_list)
    end
  end

  def update
    @user = User.find(params[:user_id])
    @vocabulary_list = @user.vocabulary_lists.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_vocabulary_lists_path(@user, @vocabulary_list)
    else
      if @vocabulary_list.update_attributes(params[:vocabulary_list])
        redirect_to user_vocabulary_list_path(@user, @vocabulary_list), notice: "Successfully updated vocabulary list."
      else
        render :edit
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_vocabulary_lists_path(@user)
    else
      @vocabulary_list = current_user.vocabulary_list.find(params[:id])
      @vocabulary_list.destroy
      redirect_to user_vocabulary_lists_path(@user), notice: "Successfully destroyed vocabulary list"
    end
  end
end