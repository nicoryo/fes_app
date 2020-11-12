# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :artists, dependent: :destroy
  has_many :favs
  has_many :favorite_artists, through: :favs, source: :artist
  has_many :comments, dependent: :destroy

  has_many :active_relationships, class_name:  'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'following_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :following, through: :active_relationships, source: :following

  def registrating(artist)
    favs.find_or_create_by(artist_id: artist.id) unless favs.include?(artist)
  end

  def already_faved?(artist)
    favorite_artists.include?(artist)
  end

  def remove(artist)
    unregistrate = favs.find_by(artist: artist.id)
    unregistrate&.destroy
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def follower?(other_user)
    followers.include?(other_user)
  end

  def follow!(other_user)
    active_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(following_id: other_user.id).destroy
  end

  def matching?(other_user)
    followers.include?(other_user) && following.include?(other_user)
  end
end
