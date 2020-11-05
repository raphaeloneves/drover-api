class CreateCars < ActiveRecord::Migration[5.2]
  def up
    create_table :cars do |t|
      t.integer :model_id, null: false
      t.integer :year, null: false
      t.string :color
      t.date :available_at, null: false

      t.timestamps
    end
    change_column_default :cars, :color, 'white'
  end

  def down
    drop_table :cars
  end
end
