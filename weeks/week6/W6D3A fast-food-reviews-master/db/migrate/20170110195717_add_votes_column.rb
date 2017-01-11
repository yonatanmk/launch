class AddVotesColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :up_votes, :integer, default: 0
    add_column :restaurants, :down_votes, :integer, default: 0
  end
end
