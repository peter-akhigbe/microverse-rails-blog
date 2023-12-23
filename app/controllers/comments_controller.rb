class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = @user.id

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment created!'
    else
      flash.now[:errors] = 'Invalid comment!'
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      redirect_to user_post_path(@user, @post), notice: 'Comment deleted!'
      update_post_comments_counter
    else
      redirect_to user_post_path(@user, @post), alert: 'Invalid Operation'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def update_post_comments_counter
    @post.update(comments_counter: @post.comments.count)
  end
end
