class DropIdColumnOnJoinTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :applications, :id
    remove_column :attendances, :id

    execute("ALTER TABLE applications ADD PRIMARY KEY (user_id, activities_id)")
    execute("ALTER TABLE attendances ADD PRIMARY KEY (user_id, activities_id)")
  end
end
