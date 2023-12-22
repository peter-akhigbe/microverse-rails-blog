class PostsController < ApplicationController
  before_action :set_user, only: %i[index show new create]

  def index
    @posts = Post.includes(:comments, :author).where(author_id: params[:user_id])
  end

  def show
    @post = Post.includes(:author, :comments).find_by(author_id: params[:user_id], id: params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = @user.posts.new(post_params)
    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def set_user
    @user = current_user
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
