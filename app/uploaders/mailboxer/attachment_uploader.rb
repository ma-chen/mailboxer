class Mailboxer::AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/messages/#{model.conversation_id}/#{model.id}"
  end

  version :small do
    process resize_to_fill: [200,200]
  end
end
