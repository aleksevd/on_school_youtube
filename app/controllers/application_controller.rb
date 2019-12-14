class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :flash_position, :gon

  private

  def flash_position
    @flash_position ||= :top
  end
end
