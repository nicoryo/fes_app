# frozen_string_literal: true

class FavsController < ApplicationController
 
  def create
    @artist = Artist.find(params[:artist_id])
    current_user.registrating(@artist)
    respond_to do |format|
      format.html { redirect_to @artist }
      format.js
    end
  end


  def destroy
    @artist = Artist.find(params[:artist_id])
    current_user.remove(@artist)
    respond_to do |format|
      format.html { redirect_to @artist }
      format.js
    end
  end
end
