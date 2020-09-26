# frozen_string_literal: true

class ArtistsController < ApplicationController
  # before_create :set_id
  require 'rspotify'
  require 'open-uri'
  RSpotify.authenticate(ENV['CLIENT_KEY'], ENV['CLIENT_SECRET_KEY'])

  def new
    @artist = Artist.new
    @searchartists = RSpotify::Artist.search(params[:search]) if params[:search].present?
  end

  def create
    @artist = Artist.create(artist_params)
    if @artist.save
      flash[:success] = '登録しました'
      redirect_to @artist
    else
      flash[:danger] = '登録できませんでした'
      redirect_to root_path
    end
  end

  def index
    @artist = Artist.all
    @users  = User.all
    @searchartists = RSpotify::Artist.search(params[:search]) if params[:search].present?
  end

  def show
    @artist = Artist.find(params[:id])
    @user_Favorited = @artist.favorited_users
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    @artist.update(artist_params) if @artist_id == current_artist.id
    render action: :edit unless @artist.save
  end

  private

  def artist_params
    params.require(:artist).permit(:id, :icon, :name)
  end
end
