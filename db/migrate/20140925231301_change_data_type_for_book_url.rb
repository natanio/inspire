class ChangeDataTypeForBookUrl < ActiveRecord::Migration
  def change
    change_table :books do |t|
      t.string :url
    end
  end
end
