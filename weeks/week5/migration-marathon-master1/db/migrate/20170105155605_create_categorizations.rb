class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |table|
      table.belongs_to :book
      table.belongs_to :category
    end
  end
end
