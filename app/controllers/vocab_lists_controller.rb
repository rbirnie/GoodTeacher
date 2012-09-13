class VocabListsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @vocab_lists = @user.vocab_lists
    @title = "My Vocab Lists"
  end
  

  def show
    @user = User.find(params[:user_id])
    @vocab_list = @user.vocab_lists.find(params[:id])
    @title = @vocab_list.name
    @commentable = VocabList.find(params[:id])
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @title = "New Vocab List"
    @user = User.find(params[:user_id])
    @unit = @user.units.find(params[:unit_id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_vocab_lists_path(@user)
    end
    @vocab_list = @unit.vocab_lists.build
  end

  def create
    @user = User.find(params[:user_id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_vocab_lists_path(@user)
    else
      @unit = @user.units.find(params[:unit_id])
      @vocab_list = VocabList.new(params[:vocab_list])
      @vocab_list.user_id = current_user.id
      @unit.vocab_lists << @vocab_list
      @unit.save
    end
    if @unit.save
      redirect_to user_vocab_list_path(@user, @vocab_list), notice: "Successfully created vocab list."
    else
      render :action => :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @vocab_list = @user.vocab_lists.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_vocab_list_path(@user, @vocab_list)
    end
  end

  def update
    @user = User.find(params[:user_id])
    @vocab_list = @user.vocab_lists.find(params[:id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_vocab_lists_path(@user, @vocab_list)
    else
      if @vocab_list.update_attributes(params[:vocab_list])
        redirect_to user_vocab_list_path(@user, @vocab_list), notice: "Successfully updated vocab list."
      else
        render :edit
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    if current_user.nil? || current_user.id != @user.id
      redirect_to user_vocab_lists_path(@user)
    else
      @vocab_list = current_user.vocab_list.find(params[:id])
      @vocab_list.destroy
      redirect_to user_vocab_lists_path(@user), notice: "Successfully destroyed vocab list"
    end
  end
end