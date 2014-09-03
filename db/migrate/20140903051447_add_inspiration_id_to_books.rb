class AddInspirationIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :inspiration_id, :integer
  end
end
