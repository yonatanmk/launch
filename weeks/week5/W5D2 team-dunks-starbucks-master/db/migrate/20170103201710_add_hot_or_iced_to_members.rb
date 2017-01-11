class AddHotOrIcedToMembers < ActiveRecord::Migration
  def change
    add_column :members, :hot_or_iced, :string
  end
end
