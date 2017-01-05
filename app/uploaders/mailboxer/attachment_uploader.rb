class Mailboxer::AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/messages/#{model.conversation_id}/#{model.id}"
  end

  version :small, :if => :image? do
    process resize_to_fit: [200,200]
  end

  protected

  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end
end
