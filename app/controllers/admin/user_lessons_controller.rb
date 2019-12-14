class Admin::UserLessonsController < Admin::BaseController
  skip_before_action :set_active_main_menu_item
  before_action :set_breadcrumbs, only: :index

  def index
    @user_lessons = course.user_lessons.page(params[:page])
  end

  def update
    @user_lesson = UserLesson.find(params[:id])

    if @user_lesson.update(user_lesson_params)
      redirect_to [:new, :admin, @user_lesson, :answer], notice: "Статус успешно изменен на #{@user_lesson.state}"
    else
      redirect_to [:new, :admin, @user_lesson, :answer], alert: "Не удалось изменить статус на #{user_lesson_params[:state_event]}. #{@user_lesson.errors.full_messages.join(', ')}"
    end
  end

  private

  def course
    @course = Course.find(params[:course_id])
  end

  def set_breadcrumbs
    add_breadcrumb "Проверка", [:admin, course, :user_lessons]
    add_breadcrumb course.name, '#'
  end

  def set_active_main_menu_item
    @main_menu[:user_lessons][:active] = true
  end

  def user_lesson_params
    params.require(:user_lesson).permit(:state_event)
  end
end
