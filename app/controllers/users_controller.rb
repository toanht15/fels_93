class UsersController < ApplicationController
  before_action :logged_in_user, only: [:update, :edit]
  before_action :load_user, except: [:index, :new, :create]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "title"
      redirect_to @user
    else
      render :new
    end
  end

  def index
    @users = User.paginate page: params[:page]
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find params[:id]
  end
end
