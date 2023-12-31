class PostsController < ApplicationController
  load_and_authorize_resource # except: %i[index show]
  before_action :set_user, only: %i[index show new create]

  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(:comments, :author)
      .where(author_id: @user.id)
      .order(created_at: :desc)
      .paginate(page: params[:page], per_page: 5)
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

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    if @post.destroy
      redirect_to user_posts_path(@user)
      update_user_posts_counter
    else
      alert 'Error'
    end
  end

  private

  def set_user
    @user = current_user
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def update_user_posts_counter
    @post.author.update(posts_counter: @post.author.posts.count)
  end
end
