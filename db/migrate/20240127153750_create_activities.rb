class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :title, null: false
      t.string :overview, null: false
      t.string :body, null: false
      t.string :image
      t.integer :manpower_needed, null: false
      t.string :location, null: false
      t.bigint :time_start, null: false
      t.bigint :time_end, null: false

      t.timestamps
    end
  end
end
