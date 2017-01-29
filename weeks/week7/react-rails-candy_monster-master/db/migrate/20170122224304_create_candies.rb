class CreateCandies < ActiveRecord::Migration
  def change
    create_table :candies do |t|
      t.string :name, null: false
      t.text :image_url
      t.text :description
      t.integer :points, default: 0

      t.timestamps
    end
  end
end
