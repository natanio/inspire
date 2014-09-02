class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :link
      t.string :genre
      t.text :image
      t.text :description
      t.string :date_publish

      t.timestamps
    end
  end
end
