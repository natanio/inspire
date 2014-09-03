class AddUserIdToInspirations < ActiveRecord::Migration
  def change
    add_column :inspirations, :user_id, :integer
  end
end
