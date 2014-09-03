class RemoveImageFromBooks < ActiveRecord::Migration
  def change
  	remove_column :books, :image, :text
  end
end
