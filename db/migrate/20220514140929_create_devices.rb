class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.belongs_to :user
      t.decimal :offset, precision: 4, scale: 2, default: 0
    end
  end
end
