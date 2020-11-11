class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  # 順序を番号の大きい順にする
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
