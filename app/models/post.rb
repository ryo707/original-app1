class Post < ApplicationRecord
  validates :nickname, :title, :text, presence: true
  belongs_to :user
end
