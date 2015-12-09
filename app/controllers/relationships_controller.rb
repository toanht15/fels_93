class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @title = params[:relationship]
    @user = User.find params[:user_id]
    if params[:relationship] == "following"
      @users = @user.following
    else
      @users = @user.followers
    end
    @users = @users.paginate page: params[:page]
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
