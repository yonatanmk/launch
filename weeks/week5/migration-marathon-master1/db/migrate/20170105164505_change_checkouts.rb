class ChangeCheckouts < ActiveRecord::Migration
  def change
    remove_column :checkouts, :person
  end
end
