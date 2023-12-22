require 'rails_helper'

RSpec.describe 'posts', type: :feature do
  describe '#index' do
    before(:each) do
      @user = User.create(name: 'Peter', bio: 'this is Peter', photo: 'photo_url_peter')

      @post = Post.create(title: 'Test Post Title', text: 'this is the post text', author_id: @user.id)

      @comment1 = Comment.create(text: 'comment one', user_id: @user.id, post_id: @post.id)
      @comment2 = Comment.create(text: 'comment two', user_id: @user.id, post_id: @post.id)
      @comment3 = Comment.create(text: 'comment three', user_id: @user.id, post_id: @post.id)
      @comment4 = Comment.create(text: 'comment four', user_id: @user.id, post_id: @post.id)
      @comment5 = Comment.create(text: 'comment five', user_id: @user.id, post_id: @post.id)
      @comment6 = Comment.create(text: 'comment six', user_id: @user.id, post_id: @post.id)

      visit user_posts_path(@user)
    end

    it 'displays user information' do
      expect(page).to have_css('img')
      expect(page).to have_content('Peter')
      expect(page).to have_content("Number of post: #{@user.posts_counter}")
    end

    it 'displays post information' do
      expect(page).to have_content('Test Post Title')
      expect(page).to have_content('this is the post text')
      expect(page).to have_content('Likes: 0')
      expect(page).to have_content('Comments: 6')
    end

    it 'display latest comments on a post' do
      expect(page).not_to have_content('comment one')
    end

    it 'redirects to the post when clicked' do
      visit user_path(@user)
      click_link @post.title

      sleep 10
      expect(current_path).to eq(user_post_path(@user, @post))
    end
  end
end
