class User < ApplicationRecord
    has_many :posts
    has_many :comments, dependent: :destroy

    validates :name, presence: true
end
