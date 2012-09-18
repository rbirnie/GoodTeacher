class FavoritesController < ApplicationController
  before_filter :load_favorable

  def create
    @favorite = @favorable.favorites.new(params[:favorite_id])
    @favorite.favorer = current_user # ensure uses don't submit fake values
    @favorite.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @user = current_user
    @favorite = @favorable.favorites.where(favorer: current_user).first
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

private

  def load_favorable
    klass = [Unit, Course, Lesson, Assessment, VocabularyList].detect { |c| params["#{c.name.underscore}_id"] }
    if klass.blank?
      klass = [User].detect { |c| params["#{c.name.underscore}_id"] }
    end
    @favorable = klass.find(params["#{klass.name.underscore}_id"])
  end

end