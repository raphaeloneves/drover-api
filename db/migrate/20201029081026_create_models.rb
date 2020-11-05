class CreateModels < ActiveRecord::Migration[5.2]
  def change
    create_table :models do |t|
      t.string :name, null: false
      t.integer :maker_id, null: false

      t.timestamps
    end
    add_index :models, %i[name maker_id], unique: true
  end
end
