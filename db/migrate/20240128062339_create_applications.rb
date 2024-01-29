class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.timestamps
    end

    add_reference :applications, :user, index: true, foreign_key: true
    add_reference :applications, :activities, index: true, foreign_key: true
  end
end
