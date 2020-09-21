class User < ApplicationRecord
  mount_uploader :image, ImageUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :artists, dependent: :destroy
  has_many :favs,    dependent: :destroy
  has_many :artists, through: :favs

  has_many :active_relationships,class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :following, through: :active_relationships, source: :following

  def already_faved?(artist)
    self.favs.exists?(artist_id: artist.id)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def follow!(other_user)
    active_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(following_id: other_user.id).destroy
  end

end
