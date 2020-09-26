# frozen_string_literal: true

class Artist < ApplicationRecord
  has_many :favs, dependent: :destroy
  has_many :favorited_users, through: :favs, source: :user
  has_many :users, dependent: :destroy

  validates :name,  presence: true
  validates :icon,  presence: true

  # mount_uploader :icon, ImageUploader

  def already_faved?(artist)
    favs.exists?(artist_id: artist.id)
  end

  def correct_artist
    @artist = Artist.find(params[:id])
    redirect_to(root_url) unless current_artist?(@artist)
  end
end
