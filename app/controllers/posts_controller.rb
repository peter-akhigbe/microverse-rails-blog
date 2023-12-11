class PostsController < ApplicationController
  def index
    @posts = User.find(params[:user_id]).posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end
end
