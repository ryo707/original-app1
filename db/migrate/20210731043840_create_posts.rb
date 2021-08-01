class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :nickname
      t.string :title
      t.string :text
      t.text   :image
      t.string :post_date

      t.timestamps
    end
  end
end
