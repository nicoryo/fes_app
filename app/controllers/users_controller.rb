class UsersController < ApplicationController

  before_action :authenticate_user!, :only => [:show]
  def index
    @users=User.all
    @artists = Artist.all
  end

  def show
    @user=User.find(params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
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
    @user=User.find(params[:id])
  end

  def update
     @user=User.find(params[:id])
     if @user.id == current_user.id
         @user.update(user_params)
     end
     unless @user.save
     render action: :edit
     end
  end


  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def maching?
    unless current_user.following.include?(@user) && @user.following.include?(current_user)
    flash[:danger] = "相互フォローではありません"
    redirect_to root_path
    end
  end

  private
  #ストロングパラメーター
    def user_params
      params.require(:user).permit(:name, :email, :birthday, :sex,
                                   :introduction, :image)
    end
end
