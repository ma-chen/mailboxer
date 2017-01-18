class Mailboxer::AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/messages/#{model.conversation_id}/#{model.id}"
  end

  version :small, :if => :image? do
    process resize_to_fit: [200,200]
  end

  version :medium, :if => :image? do
    process resize_to_fit: [415,-1], if: :is_landscape?
    process resize_to_fit: [100000,215], if: :is_portrait?
  end

  protected

  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end

  def is_landscape?(new_file)
    image = MiniMagick::Image::read(File.binread(@file.file))
    image[:width] >= image[:height]
  end

  def is_portrait?(new_file)
    image = MiniMagick::Image::read(File.binread(@file.file))
    image[:width] < image[:height]
  end
end
