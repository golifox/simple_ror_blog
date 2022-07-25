class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :body, presence: true

  # validates id`s auto
  # tnx for magic rails
  
  
  #trying to validate id`s field`s

  # FIRST WAY

  #@users_ids = User.all.ids
  #@posts_ids = Post.all.ids

  #validates :user_id, presence: true, inclusion: { in: @users_ids }
  #validates :post_id, presence: true, inclusion: { in: @post_ids }

  # SECOND WAY

  #validates_associated :post
  #validates_associated :user
end
