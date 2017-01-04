class Mailboxer::AttachmentUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/messages/#{model.conversation_id}/#{model.id}"
  end
end
