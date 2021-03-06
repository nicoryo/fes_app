# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @users   = User.all
    @artists = Artist.all.page(params[:page]).per(10)
    if params[:name].present?
      @search_artists = Artist.where('name LIKE ?', "%#{params[:name]}%")
    else
      @search_artists = Artist.none
    end
  end

  def show
    @user = User.find(params[:id])
    @userFollowings = @user.following.page(params[:page]).per(5)
    @userFollowers = @user.followers.page(params[:page]).per(5)
    @userFavorites = @user.favorite_artists.page(params[:page]).per(10)


    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry        = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def destroy
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params) if @user.id == current_user.id
    render action: :edit unless @user.save
  end

  def favorite_artist
    @user = User.find(params[:id])
    @users = @user.favorite_artists
  end

  def following
    @title  = 'フォロー'
    @user   = User.find(params[:id])
    @users  = @user.following
    render 'show_follow'
  end

  def followers
    @title  = 'フォロワー'
    @user   = User.find(params[:id])
    @users  = @user.followers
    render 'show_follow'
  end

  private

  # ストロングパラメーター
  def user_params
    params.require(:user).permit(:name, :email, :birthday, :sex,
                                 :introduction, :image,
                                 { artist_ids: [] })
  end
end
