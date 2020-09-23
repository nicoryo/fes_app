class Artist < ApplicationRecord
  has_many :favs,    dependent: :destroy
  has_many :users, through: :favs, source: :user

  mount_uploader :icon, ImageUploader

  def already_faved?(artist)
    self.favs.exists?(artist_id: artist.id)
  end

  def correct_artist
    @artist = Artist.find(params[:id])
    redirect_to(root_url) unless current_artist?(@artist)
  end
end
