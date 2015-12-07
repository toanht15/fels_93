class Admin::CategoriesController < ApplicationController
  before_action :load_category, except: [:index, :new, :create]

  def new
    @categories = Category.new
  end

  def create
    @categories = Category.new category_params
    if @categories.save
      flash[:success] = t "title"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def index
    @categories = Category.all
  end

  def edit
  end

  def update
    if @categories.update_attributes category_params
      flash[:success] = t "update_succesfull"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    @categories.destroy
    flash[:success] = t "delete"
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end

  def load_category
    @categories = Category.find params[:id]
  end

end
