class AddBookIdToInspirations < ActiveRecord::Migration
  def change
    add_column :inspirations, :book_id, :integer
  end
end
