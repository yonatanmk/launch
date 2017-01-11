class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.belongs_to :book, null: false
      t.string :person, null: false
      t.timestamps null: false
    end
  end
end
