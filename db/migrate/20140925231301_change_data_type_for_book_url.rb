class ChangeDataTypeForBookUrl < ActiveRecord::Migration
  def change
    change_table :books do |t|
      t.change :url, :string
    end
  end
end
