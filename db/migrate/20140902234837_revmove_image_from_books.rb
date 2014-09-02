class RevmoveImageFromBooks < ActiveRecord::Migration
  def change
  	remove_column :books, :fimage, :text
  end
end
