class Admin::AnswersController < Admin::BaseController
  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :set_user_lesson, only: [:new, :create, :edit, :update]

  before_action :set_breadcrumbs, only: [:new, :index]
  before_action :set_user_lesson_answers, only: :new

  after_action :mark_answers_as_viewed, only: :new

  def index
    @course = Course.first

    @q = Answer.ransack(search_params)
    @answers = @q.result.order(id: :desc).page(params[:page])
  end

  def new
    @answer = @user_lesson.answers.build
  end

  def create
    @answer = @user_lesson.answers.build(answer_params)
    @answer.owner = @user_lesson.lesson.course.teacher

    if @answer.save
      redirect_to admin_answers_path, notice: 'Ответ успешно сохранен'
    else
      set_breadcrumbs
      set_user_lesson_answers

      flash.now[:alert] =  "Не удалось сохранить ответ. #{@answer.errors.full_messages.join('. ')}."
      render :new
    end
  end

  def edit
    add_breadcrumb 'Редактирование', '#'
  end

  def update
    if @answer.update(answer_params)
      redirect_to [:new, :admin, @user_lesson, @answer], notice: 'Ответ успешно сохранен'
    else
      set_breadcrumbs
      add_breadcrumb 'Редактирование', '#'

      flash.now[:alert] =  "Не удалось сохранить ответ. #{@answer.errors.full_messages.join('. ')}."
      render :edit
    end
  end

  def destroy
    if @answer.destroy
      redirect_to [:new, :admin, @answer.user_lesson, :answer], notice: 'Ответ успешно удален'
    else
      redirect_to [:new, :admin, @answer.user_lesson, :answer], alert: 'Не удалось удалить Ответ'
    end
  end

  private

  def set_user_lesson
    @user_lesson ||= UserLesson.find(params[:user_lesson_id])
  end

  def set_breadcrumbs
    add_breadcrumb "Проверка", [:admin, :answers]

    if @user_lesson
      add_breadcrumb @user_lesson.lesson.course.name,'#'
      add_breadcrumb @user_lesson.lesson.name, '#'
      add_breadcrumb @user_lesson.user.decorate.full_name, '#'
    end
  end

  def set_user_lesson_answers
    @answers = @user_lesson.answers.order(id: :desc)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:answers][:active] = true
  end

  def mark_answers_as_viewed
    @answers.map{ |t| t.update(viewed: true) }
  end

  def answer_params
    params.require(:answer).permit(:text, :audio, :complete, answer_images_attributes: [:file, :file_cache, :_destroy])
  end

  def search_params
    return params[:q] if params[:q]

    { viewed_eq: false,
      owner_type_eq: 'User' }
  end
end
