class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include ActionView::Helpers::AssetUrlHelper

  # Choose what kind of storage to use for this uploader:
  # storage :file
  if Rails.env.test? || Rails.env.cucumber?
    storage :file
  else
    storage :fog
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fit => [50, 50]
  end

  version :medium do
    process :resize_to_fit => [250, 211]
    # resize_to_limit(250,250)
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # def default_url(*_args)
  #   "#{ENV['FULL_APP_HOST']}#{ActionController::Base.helpers.asset_path("fallback/default_#{model.class.to_s.underscore}.png")}"
  # end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
