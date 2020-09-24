class ArtistsController < ApplicationController
  # before_create :set_id
  require 'rspotify'
  RSpotify.authenticate("e731c7b014434f0a8171fbf6a43f4c65", "1ae836c733a14bf990063b1f70ca968c")

  def new
    @artist = Artist.new
    if params[:search].present?
      @searchartists = RSpotify::Artist.search(params[:search])
    end

  end

  def create
    @artist =  Artist.new(artist_params)
    if @artist.save
      flash[:success] = "登録しました"
      redirect_to @artist
    else
      flash[:danger] = "登録できませんでした"
      redirect_to @new
    end
  end

  def index
    @artist = Artist.all
    if params[:search].present?
      @searchartists = RSpotify::Artist.search(params[:search])
    end
  end

  def show
    @artist = Artist.find(params[:id])
    @users  = User.all
    @user_Favorited = @artist.users
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist_id == current_artist.id
       @artist.update(artist_params)
    end
    unless @artist.save
    render action: :edit
    end
  end

  def create_artist
    if params[:search].present?
      @searchartists = RSpotify::Artist.search(params[:search])
    end
    @artist = @searchartists
    if params[:artist]
      @artist = Artist.create(
        name: artist["name"]
      )
    end
  end


  private
    def artist_params
      params.require(:artist).permit(:id, :name, :icon)
    end
end
