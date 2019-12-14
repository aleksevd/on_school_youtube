class Admin::DisciplinesController < Admin::BaseController
  add_breadcrumb 'Дисциплины', :admin_disciplines_path

  before_action :set_discipline, only: [:edit, :update, :destroy]

  def index
    @disciplines = Discipline.order(id: :desc).page(params[:page])
  end

  def new
    add_breadcrumb "Новая Дисциплина", new_admin_discipline_path

    @discipline = Discipline.new
  end

  def create
    @discipline = Discipline.new(discipline_params)

    if @discipline.save
      redirect_to admin_disciplines_path, notice: 'Дисциплина успешно создана'
    else
      add_breadcrumb "Новая Дисциплина", new_admin_discipline_path

      flash.now[:alert] = 'Не удалось создать Дисциплину'
      render :new
    end
  end

  def edit
    add_breadcrumb "Редактировать #{@discipline.name}", [:edit, :admin, @discipline]
  end

  def update
    if @discipline.update(discipline_params)
      redirect_to admin_disciplines_path, notice: 'Дисциплина успешно изменена'
    else
      add_breadcrumb "Редактировать #{@discipline.name}", [:edit, :admin, @discipline]
      flash.now[:alert] = 'Не удалось изменить Дисциплину'
      render :edit
    end
  end

  def destroy
    if @discipline.destroy
      redirect_to admin_disciplines_path, notice: 'Дисциплина успешно удалена'
    else
      redirect_to admin_disciplines_path, alert: 'Не удалось удалить Дисциплину'
    end
  end

  private

  def set_discipline
    @discipline = Discipline.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:disciplines][:active] = true
  end

  def discipline_params
    params.require(:discipline).permit(:name)
  end
end
