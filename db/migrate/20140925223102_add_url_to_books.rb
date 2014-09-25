class AddUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :url, :text
  end
end
