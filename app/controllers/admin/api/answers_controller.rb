class Admin::Api::AnswersController < Admin::Api::BaseController
  before_action :set_user_lesson, only: :create

  def create
    @answer = @user_lesson.answers.build(answer_params)
    @answer.owner = @user_lesson.lesson.course.teacher

    if @answer.save
      head :no_content
    else
      render json: @answer.errors.full_messages.to_json, status: :unprocessable_entity
    end
  end

  private

  def set_user_lesson
    @user_lesson ||= UserLesson.find(params[:user_lesson_id])
  end

  def answer_params
    params.require(:answer).permit(:text, :audio, :complete, answer_images_attributes: [:file, :file_cache, :_destroy])
  end
end
