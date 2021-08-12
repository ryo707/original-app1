class RemoveNicknameFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :nickname, :string
  end
end
