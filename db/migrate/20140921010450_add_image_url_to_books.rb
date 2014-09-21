class AddImageUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :aws_image_url, :string
  end
end
