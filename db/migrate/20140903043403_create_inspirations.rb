class CreateInspirations < ActiveRecord::Migration
  def change
    create_table :inspirations do |t|
      t.text :quote, :limit => 500
      t.integer :page_number
      t.integer :likes, default: 0

      t.timestamps
    end
    add_index :inspirations, :quote, unique: true
  end
end
