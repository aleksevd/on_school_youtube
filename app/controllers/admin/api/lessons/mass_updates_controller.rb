class Admin::Api::Lessons::MassUpdatesController < Admin::Api::BaseController
  def create
    ::Lessons::MassUpdate.create!(lessons_params)

    head :no_content
  end

  private

  def lessons_params
    params.permit(lessons: [:id, :position, :section_id])[:lessons].values
  end
end