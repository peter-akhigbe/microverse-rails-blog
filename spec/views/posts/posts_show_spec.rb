require 'rails_helper'

RSpec.describe 'User', type: :feature do
  before :each do
    @user = User.create(name: 'Peter', photo: 'Photo_url_peter', bio: 'this is Peter')
    @first_post = Post.create(author_id: @user.id, title: 'Post One', text: 'post one text')
    @comment = Comment.create(post_id: @first_post.id, user_id: @user.id, text: 'comment one text')
  end

  it 'shows post title' do
    visit "/users/#{@user.id}/posts/#{@first_post.id}"
    expect(page).to have_content('Post One')
  end

  it 'shows post author' do
    user_name = Post.find_by(author: @user.name)
    visit "/users/#{@user.id}/posts/#{@first_post.id}"
    expect(page).to have_content(user_name)
  end

  it 'shows number of likes and comments' do
    visit "/users/#{@user.id}/posts/#{@first_post.id}"
    user_post = @user.posts.find_by(id: @first_post.id)
    expect(page).to have_content(user_post.comments.count)
    expect(page).to have_content(user_post.likes.count)
  end

  it 'shows the post text' do
    visit "/users/#{@user.id}/posts/#{@first_post.id}"
    expect(page).to have_content(@first_post.text)
  end
  it 'shows the username of all authors' do
    author_name = Comment.find_by(user_id: @user.name)
    visit "/users/#{@user.id}/posts/#{@first_post.id}"
    expect(page).to have_content(author_name)
  end

  it 'shows the comment left by a author' do
    visit "/users/#{@user.id}/posts/#{@first_post.id}"
    expect(page).to have_content(@comment.text)
  end
end
