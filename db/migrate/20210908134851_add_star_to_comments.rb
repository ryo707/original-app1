class AddStarToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :star, :float
  end
end
