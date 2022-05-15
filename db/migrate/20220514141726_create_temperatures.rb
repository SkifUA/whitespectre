class CreateTemperatures < ActiveRecord::Migration[5.2]
  def change
    create_table :temperatures do |t|
      t.belongs_to :device
      t.decimal :magnitude, precision: 4, scale: 2, null: false
      t.decimal :offset, precision: 4, scale: 2, null: false

      t.timestamps
    end
  end
end
