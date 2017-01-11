class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :subject, null: false
      t.string :story, null: false

      t.timestamps null: false
    end
  end
end
