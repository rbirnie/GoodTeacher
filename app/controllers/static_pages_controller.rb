class StaticPagesController < ApplicationController
  def home
    @title = "Home"
    if current_user
      @courses = current_user.courses
      @units = current_user.units
      @user = current_user
    end
  end

  def about
    @title = "About Us"
  end

  def privacypolicy
    @title = "Privacy Policy"
  end
end
