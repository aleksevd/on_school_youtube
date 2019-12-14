class Admin::AdminsController < Admin::BaseController
  add_breadcrumb 'Админы', :admin_admins_path

  before_action :set_admin, only: [:edit, :update, :destroy]

  def index
    @admins = Admin.order(id: :desc).page(params[:page])
  end

  def new
    add_breadcrumb "Новый Админ", new_admin_admin_path

    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to admin_admins_path, notice: 'Админ успешно создан'
    else
      add_breadcrumb "Новый Админ", new_admin_admin_path

      flash.now[:alert] = 'Не удалось создать Админа'
      render :new
    end
  end

  def edit
    add_breadcrumb "Редактировать #{@admin.first_name} #{@admin.last_name}", [:edit, :admin, @admin]
  end

  def update
    if @admin.update(admin_params)
      redirect_to admin_admins_path, notice: 'Админ успешно изменен'
    else
      add_breadcrumb "Редактировать #{@admin.first_name} #{@admin.last_name}", [:edit, :admin, @admin]
      flash.now[:alert] = 'Не удалось изменить Админа', [:admin, @admin]
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admin_admins_path, notice: 'Админ успешно удален'
    else
      redirect_to admin_admins_path, alert: 'Не удалось удалить Админа'
    end
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def set_active_main_menu_item
    @main_menu[:admins][:active] = true
  end

  def admin_params
    params.require(:admin).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
