# frozen_string_literal: true

class FavsController < ApplicationController
  def create
    artist = Artist.find(params[:artist_id])
    current_user.registrating(artist)
    flash[:success] = 'おきにしました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    artist = Artist.find(params[:artist_id])
    current_user.remove(artist)
    flash[:success] = 'おきにをやめました'
    redirect_back(fallback_location: root_path)
  end
end
