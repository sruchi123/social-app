class AddConfirmColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_confirm, :boolean,  default: false
  end
end
