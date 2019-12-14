class AnswerAudioUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process :convert_to_mp3

  def convert_to_mp3
    target_path = convert_name(current_path)

    unless system("ffmpeg -i #{current_path} -acodec libmp3lame #{target_path}")
      raise CarrierWave::ProcessingError, I18n.translate("errors.messages.convertion_error")
    end

    file.delete

    @file = CarrierWave::SanitizedFile.new(File.open(target_path))
    @filename = convert_name(@filename)
  end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   convert_name(original_filename)
  # end

  def extension_whitelist
    %w(ogg)
  end

  private

  def convert_name(value)
    "#{value.chomp('.ogg')}.mp3"
  end
end
