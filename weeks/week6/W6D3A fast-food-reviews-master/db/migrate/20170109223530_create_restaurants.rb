class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
