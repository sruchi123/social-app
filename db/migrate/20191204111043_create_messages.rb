class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :receiver_id
      t.integer :sender_id
      t.integer :conversation_id
      t.text    :text  
      t.timestamps
    end
  end
end
