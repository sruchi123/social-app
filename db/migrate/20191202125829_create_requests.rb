class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :receiver_id
      t.string :sender_id
      t.boolean :is_accept ,default: :false
      t.timestamps
    end
  end
end
