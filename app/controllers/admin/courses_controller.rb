class Admin::CoursesController < Admin::BaseController
  add_breadcrumb 'Курсы', :admin_courses_path

  before_action :set_course, only: [:edit, :update, :destroy]

  def index
    @courses = Course.order(id: :desc).page(params[:page])
  end

  def new
    add_breadcrumb "Новый Курс", new_admin_course_path

    @course = Course.new
    build_sections
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to admin_courses_path, notice: 'Курс успешно создан'
    else
      add_breadcrumb "Новый Курс", new_admin_course_path
      build_sections

      flash.now[:alert] = 'Не удалось создать Курс'
      render :new
    end
  end

  def edit
    build_sections

    add_breadcrumb "Редактировать #{@course.name}", [:edit, :admin, @course]
  end

  def update
    if @course.update(course_params)
      redirect_to admin_courses_path, notice: 'Курс успешно изменен'
    else
      add_breadcrumb "Редактировать #{@course.name}", [:edit, :admin, @course]
      build_sections

      flash.now[:alert] = 'Не удалось изменить Курс'
      render :edit
    end
  end

  def destroy
    if @course.destroy
      redirect_to admin_courses_path, notice: 'Курс успешно удален'
    else
      redirect_to admin_courses_path, alert: "Не удалось удалить Курс, #{@course.errors.full_messages.join(', ')}"
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:courses][:active] = true
  end

  def build_sections
    @course.sections.build if @course.sections.empty?
  end

  def course_params
    params.require(:course).permit(:name, :description, :teacher_id, :main_image,
                                   :main_image_cache, discipline_ids: [],
                                   sections_attributes: [:_destroy, :id, :name, :description, :position])
  end
end
