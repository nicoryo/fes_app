class CommentsController < ApplicationController
def show
  @comment = Comment.find(params[:id])
end

def create
  @comment  = Comment.new(comment_params)
  respond_to do |format|
    if @comment.save!
      format.html { redirect_to "/artists/#{@comment.artist_id}" }
      format.js
    else
    end
  end
end

def destroy
end

private

  def comment_params
    params.require(:comment).permit(:user_id, :content, :artist_id).merge(user_id: current_user.id)
  end
end
