class WordsController < ApplicationController
  def index
    @words = nil
    @categories = Category.all
    if params[:category_id]
      @category = Category.find params[:category_id]
      case params[:condition]
      when Settings.word_learned
        @words = Word.learn current_user, @category
      when Settings.word_notlearned
        @words = Word.not_learn current_user, @category
      when Settings.word_all
        @words = @category.words
      end
    end
  end
end
