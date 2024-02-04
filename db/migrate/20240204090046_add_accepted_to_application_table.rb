class AddAcceptedToApplicationTable < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :accepted, :boolean, null: false, default: false
  end
end
