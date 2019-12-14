class Admin::Api::TinymceImagesController < Admin::Api::BaseController

  def create
    image = TinymceImage.new(tinymce_image_params)
    image.owner = owner

    if image.save
      render json: { image: { url: image.file.url } }, content_type: "text/html"
    else
      render json: { error: { message: image.errors.full_messages.join(', ') } }, content_type: "text/html"
    end
  end

  private

  def tinymce_image_params
    params.permit(:file)
  end

  def owner
    @owner ||= params[:owner].capitalize.constantize.find(params["#{params[:owner]}_id".to_sym])
  end
end
