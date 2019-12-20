class AddConfirmationTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmation_sent_at, :datetime
  end
end
