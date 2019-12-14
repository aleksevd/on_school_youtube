class LessonsController < ApplicationBaseController
  before_action :authenticate_user!

  before_action :set_course, only: [:index, :show]
  before_action :set_breadcrumbs, only: [:index, :show]
  before_action :set_inner_flash_position, only: [:index, :show]

  def index
    authorize_action_for @course
    add_breadcrumb 'Программа занятий', '#'
  end

  def show
    @lesson = @course.lessons.find(params[:id])
    authorize_action_for @lesson

    @user_lesson = current_user.user_lessons.find_by(lesson: @lesson)
    @answer = current_user.answers.new(user_lesson: @user_lesson)
    # @answer.answer_images.build

    add_breadcrumb 'Программа занятий', [@course, :lessons]
    add_breadcrumb @lesson.name, '#'
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_breadcrumbs
    add_breadcrumb @course.name, @course
  end

  def set_inner_flash_position
    @flash_position = :inner
  end
end
