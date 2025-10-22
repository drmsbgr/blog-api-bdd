class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  # Çoka-çok ilişki (PostTag üzerinden)
  has_many :post_tags
  has_many :tags, through: :post_tags
end
