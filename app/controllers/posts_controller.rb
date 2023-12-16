class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = User.find(params[:user_id]).posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)
    if @post.save
      redirect_to user_post_path(@user, @post)
    else
      puts @user
      puts @post.errors.full_messages
      flash.now[:errors] = 'Invalid post!'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
