# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @users   = User.all
    @artists = Artist.all
    if params[:name].present?
      @search_artists = Artist.where('name LIKE ?', "%#{params[:name]}%")
    else
      @search_artists = Artist.none
    end
  end

  def show
    @user = User.find(params[:id])
    @userFollowings = @user.following
    @userFollwers = @user.followers
    @userFavorites = @user.favorite_artists

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

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name     = "guest_user"
      user.sex      = "1"
      user.birthday = "1990.11.1"
      user.introduction = "Hello"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end



  private

  # ストロングパラメーター
  def user_params
    params.require(:user).permit(:name, :email, :birthday, :sex,
                                 :introduction, :image,
                                 { artist_ids: [] })
  end
end
