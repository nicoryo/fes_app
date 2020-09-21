class Artist < ApplicationRecord
  mount_uploader :icon, ImageUploader

  has_many :favs,    dependent: :destroy
  has_many :users, through: :favs

  def correct_artist
    @artist = Artist.find(params[:id])
    redirect_to(root_url) unless current_artist?(@artist)
  end
end
