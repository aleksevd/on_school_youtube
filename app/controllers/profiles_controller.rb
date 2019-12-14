class ProfilesController < ApplicationBaseController
  before_action :authenticate_user!
  before_action :set_inner_flash_position, only: [:edit, :update]

  add_breadcrumb 'Профиль', :edit_profile
  add_breadcrumb 'Редактирование', '#'

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to after_update_redirect_path, notice: 'Профиль успешно изменен'
    else
      flash.now[:alert] = 'Не удалось изменить Профиль'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation,
                                 :avatar, :avatar_cache)
  end

  def after_update_redirect_path
    if params[:password]
      new_user_session_path
    else
      edit_profile_path
    end
  end

  def set_inner_flash_position
    @flash_position = :inner
  end
end
