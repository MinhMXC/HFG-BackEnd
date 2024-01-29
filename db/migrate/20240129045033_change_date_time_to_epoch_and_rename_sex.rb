class ChangeDateTimeToEpochAndRenameSex < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :sex, :is_male
    remove_column :users, :hp_number
    add_column :users, :handphone, :bigint

    remove_column :users, :created_at
    remove_column :users, :updated_at
    add_column :users, :created_at, :bigint
    add_column :users, :updated_at, :bigint

    remove_column :activities, :created_at
    remove_column :activities, :updated_at
    add_column :activities, :created_at, :bigint
    add_column :activities, :updated_at, :bigint

    remove_column :applications, :created_at
    remove_column :applications, :updated_at
    add_column :applications, :created_at, :bigint
    add_column :applications, :updated_at, :bigint

    remove_column :attendances, :created_at
    remove_column :attendances, :updated_at
    add_column :attendances, :created_at, :bigint
    add_column :attendances, :updated_at, :bigint
  end
end
