class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :body, presence: true
end
