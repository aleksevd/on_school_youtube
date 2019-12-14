class ApplicationBaseController < ApplicationController
  respond_to :html

  private

  def authority_forbidden(error)
    redirect_to request.referrer.presence || root_path, alert: 'У вас нет доступа к данной странице'
  end
end
