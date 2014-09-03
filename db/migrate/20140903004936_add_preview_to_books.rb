class AddPreviewToBooks < ActiveRecord::Migration
  def change
    add_column :books, :preview, :text
  end
end
