class Fav < ApplicationRecord
  belongs_to :artist
  belongs_to :user
  validates_uniqueness_of :artist_id, scope: :user_id

end
