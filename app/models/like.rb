class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  after_save :update_post_likes_counter

  private

  def update_post_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
