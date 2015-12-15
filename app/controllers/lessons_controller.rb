class LessonsController < ApplicationController
  def create
    @category = Category.find params[:category_id]
    @lesson = Lesson.new user: current_user, category: @category
    if @lesson.save
      flash[:success] = t "lesson_create_success"
      redirect_to category_lesson_path @category, @lesson
    else
      flash[:danger] = t "lesson_create_danger"
      redirect_to request.referrer
    end
  end

  def show
    @lesson = Lesson.find params[:id]
  end

  def update
    @lesson = Lesson.find params[:id]
    if @lesson.update_attributes lesson_params
      flash[:success] = t "lesson_update_success"
      render :show_result
    else
      flash[:danger] = t "lesson_update_danger"
      redirect_to request.referrer
    end
  end

  private
    def lesson_params
      params.require(:lesson).permit results_attributes: [:id, :answer_id]
    end
end
