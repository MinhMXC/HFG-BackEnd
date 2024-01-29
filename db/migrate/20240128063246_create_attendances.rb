class CreateAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :attendances do |t|
      t.boolean :attended

      t.timestamps
    end

    add_reference :attendances, :user, index: true, foreign_key: true
    add_reference :attendances, :activities, index: true, foreign_key: true
  end
end
