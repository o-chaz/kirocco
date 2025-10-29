class ItemImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process resize_to_limit: [800, 800]

  def extension_allowlist
    %w[jpg jpeg png]
  end
end
