class AddFavorite < ActiveRecord::Migration
  def up
    add_column :books, :favorite, :boolean, null: false, default: false
  end

  def down
    remove_column :books, :favorite
  end

end
