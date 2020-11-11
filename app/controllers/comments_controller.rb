class CommentsController < ApplicationController
def show
  @comment = Comment.find(params[:id])
end

def create
  @comment  = Comment.create!(comment_params)
end

def destroy
end

private

  def comment_params
    params.require(:comment).permit(:user_id, :content, :artist_id).merge(user_id: current_user.id)
  end
end
