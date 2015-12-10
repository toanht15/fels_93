class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.order_by.paginate page: params[:page]
    end
  end

  def about
  end
end
