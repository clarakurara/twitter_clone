class PagesController < ApplicationController
  def home
    if logged_in?
    @user = current_user
    @micropost = current_user.microposts.build #if logged_in?
    @feed_item = current_user.feed.paginate(page: params[:page], per_page: 12)
    end
  end

  def about
  end

  def contact
  end
end