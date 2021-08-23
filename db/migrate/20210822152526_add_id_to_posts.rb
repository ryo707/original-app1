class AddIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :id, :integer
  end
end
