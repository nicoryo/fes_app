class FavsController < ApplicationController
  def create
    @fav = current_user.favs.create(artist_id: params[:artist_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @fav = fav.find_by(artist_id: params[:artist_id], user_id: current_user.id)
    @fav.destroy
    redirect_back(fallback_location: root_path)
  end
end
