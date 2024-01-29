class RenameColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :applications, :activities_id, :activity_id
    rename_column :attendances, :activities_id, :activity_id
  end
end
