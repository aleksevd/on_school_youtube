class AnswersController < ApplicationBaseController
  before_action :authenticate_user!
  before_action :set_lesson_and_course
  before_action :set_user_lesson

  layout false

  def index
    authorize_action_for @lesson

    if @lesson.without_homework?
      redirect_to [@course, @lesson], alert: 'У занятия нет домашнего задания'
      return
    end

    @answer = Answer.new()
    @answer.answer_images.build
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.owner = current_user
    @answer.user_lesson = @user_lesson

    authorize_action_for @answer

    if @answer.save
      flash[:notice] = 'Ответ успешно сохранен'
      head :no_content
    else
      @answer.answer_images.build if @answer.answer_images.empty?
      render :index, status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:text, answer_images_attributes: [:file, :file_cache, :_destroy])
  end

  def set_lesson_and_course
    @lesson = Lesson.find(params[:lesson_id])
    @course = @lesson.course
  end

  def set_user_lesson
    @user_lesson = current_user.user_lessons.find_by(lesson: @lesson)
  end
end
