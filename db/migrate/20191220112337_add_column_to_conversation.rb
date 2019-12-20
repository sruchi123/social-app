class AddColumnToConversation < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations ,:sender_id, :integer
    add_column :conversations ,:receiver_id, :integer 
  end
end
