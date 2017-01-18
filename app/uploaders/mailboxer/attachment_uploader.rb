class Mailboxer::AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/messages/#{model.conversation_id}/#{model.id}"
  end

  version :small, :if => :image? do
    process resize_to_fit: [200,200]
  end

  version :medium, :if => :image? do
    if is_landscape? current_path
      process resize_to_fit: [415, -1]
    else
      process resize_to_fit: [-1, 215]
    end
  end

  protected

  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end

  def is_landscape? path
    image = MiniMagick::Image.open(path)
    image[:width] >= image[:height]
  end

  def is_portrait? path
    image = MiniMagick::Image.open(path)
    image[:width] < image[:height]
  end
end
