class AddApplicationForeignKeyToAttendance < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :id, :numeric, null: false
    add_index :applications, :id, unique: true
    add_reference :attendances, :applications, index: true, foreign_key: true, null: false
    execute "CREATE SEQUENCE application_id OWNED BY applications.id"
    execute "ALTER TABLE applications ALTER COLUMN id SET DEFAULT nextval('application_id')"
  end
end
