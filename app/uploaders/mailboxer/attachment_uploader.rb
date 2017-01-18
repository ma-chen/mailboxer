class Mailboxer::AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/messages/#{model.conversation_id}/#{model.id}"
  end

  version :small, :if => :image? do
    process resize_to_fit: [200,200]
  end

  version :medium, :if => :image? && :is_landscape? do
    process resize_to_fit: [415,-1]
  end

  version :medium, :if => :image? && :is_portrait? do
    process resize_to_fit: [-1,215]
  end

  protected

  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end

  def is_landscape? picture
    image = MiniMagick::Image.open(picture.path)
    image[:width] >= image[:height]
  end

  def is_portrait? picture
    image = MiniMagick::Image.open(picture.path)
    image[:width] < image[:height]
  end
end
