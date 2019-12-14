class Admin::Api::BaseController < ApplicationController
  before_action :authenticate_admin!

  respond_to :json
end