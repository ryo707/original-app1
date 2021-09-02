class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string  :title
      t.string  :text
      t.text  :image
      t.float :rate
      t.timestamps
    end
  end
end
