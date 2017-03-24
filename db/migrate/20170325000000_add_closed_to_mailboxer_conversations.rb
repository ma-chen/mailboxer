class AddClosedToMailboxerConversations < ActiveRecord::Migration
  def change
    add_column :mailboxer_conversations, :is_closed, :boolean, default: false
  end
end
