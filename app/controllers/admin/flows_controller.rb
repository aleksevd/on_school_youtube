class Admin::FlowsController < Admin::BaseController
  before_action :set_course_and_breadcrumbs
  before_action :set_flow, only: [:edit, :update, :destroy]

  def index
    @flows = @course.flows.order(starts_at: :desc)
  end

  def new
    add_breadcrumb "Новый поток", [:new, :admin, @course, :flow]

    @flow = @course.flows.build
  end

  def create
    @flow = @course.flows.build(flow_params)

    if @flow.save
      redirect_to [:admin, @course, :flows], notice: 'Поток успешно создан'
    else
      add_breadcrumb "Новый Поток", [:new, :admin, @course, :flow]

      flash.now[:alert] = 'Не удалось создать Поток'
      render :new
    end
  end

  def edit
    add_breadcrumb "Редактировать поток #{l(@flow.starts_at, format: :long)}", [:edit, :admin, @course, @flow]
  end

  def update
    if @flow.update(flow_params)
      redirect_to [:admin, @course, :flows], notice: 'Поток успешно изменен'
    else
      add_breadcrumb "Редактировать поток #{l(@flow.starts_at, format: :long)}", [:edit, :admin, @course, @flow]
      flash.now[:alert] = 'Не удалось изменить Поток'
      render :edit
    end
  end

  def destroy
    if @flow.destroy
      redirect_to [:admin, @course, :flows], notice: 'Поток успешно удален'
    else
      redirect_to [:admin, @course, :flows], alert: 'Не удалось удалить Поток'
    end
  end

  private

  def set_course_and_breadcrumbs
    @course = Course.find(params[:course_id])

    add_breadcrumb 'Курсы', :admin_courses_path
    add_breadcrumb @course.name, [:admin, @course, :flows]
    add_breadcrumb 'Потоки', [:admin, @course, :flows]
  end

  def set_flow
    @flow = Flow.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:courses][:active] = true
  end

  def flow_params
    params.require(:flow).permit(:starts_at, :checks_finish_at, :finishes_at, :price)
  end
end
