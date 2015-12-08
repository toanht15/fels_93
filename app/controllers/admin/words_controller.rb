class Admin::WordsController < ApplicationController
  before_action :load_categories
  before_action :load_word, only: [:destroy, :edit, :update]

  def index
    @words=Word.order_by.paginate page: params[:page]
  end

  def edit
  end

  def new
    @word = Word.new
    Settings.number_answer.times do
      @answer = @word.answers.build
    end
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "create_succesfull"
      redirect_to admin_words_path
    else
      render :edit
    end
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "update_succesfull"
      redirect_to admin_words_path
    else
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t "delete"
      redirect_to admin_words_path
    end
  end

  private

  def word_params
    params.require(:word).permit :content, :category_id, answers_attributes: [:id,
      :content, :correct]
  end

  def load_word
    @word = Word.find params[:id]
  end

  def load_categories
    @categories = Category.all
  end
end
