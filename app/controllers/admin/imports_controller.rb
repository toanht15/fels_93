class Admin::ImportsController < ApplicationController
  def index

  end

  def create
    Word.import params[:file]
    flash[:success] = t "import_suscess"
    redirect_to admin_words_url
  end
end
