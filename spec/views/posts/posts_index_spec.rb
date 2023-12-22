require 'rails_helper'

RSpec.describe 'posts', type: :feature do
  describe '#index' do
    before(:each) do
      @user_peter = User.create(name: 'Peter', bio: 'this is Peter', photo: 'photo_url_peter')
      @user_john = User.create(name: 'John', bio: 'this is John', photo: 'photo_url_john')

      @post1 = @user_peter.posts.create(title: 'Post One', text: 'one: post text')
      @post2 = @user_peter.posts.create(title: 'Post Two', text: 'two: post text')
      @post3 = @user_peter.posts.create(title: 'Post Three', text: 'three: post text')
      @post4 = @user_peter.posts.create(title: 'Post Four', text: 'four: post text')
      @post5 = @user_peter.posts.create(title: 'Post Fix', text: 'five: post text')
      @post6 = @user_peter.posts.create(title: 'Post Six', text: 'six: post text')

      @comment1 = Comment.create(text: 'comment one', user_id: @user_john.id, post_id: @post3.id)
      @comment2 = Comment.create(text: 'comment two', user_id: @user_john.id, post_id: @post3.id)
      @comment3 = Comment.create(text: 'comment three', user_id: @user_john.id, post_id: @post3.id)
      @comment4 = Comment.create(text: 'comment four', user_id: @user_john.id, post_id: @post3.id)
      @comment5 = Comment.create(text: 'comment five', user_id: @user_john.id, post_id: @post3.id)
      @comment6 = Comment.create(text: 'comment six', user_id: @user_john.id, post_id: @post3.id)

      visit user_posts_path(@user_peter)
    end

    it 'displays user information' do
      expect(page).to have_css('img')
      expect(page).to have_content('Peter')
      expect(page).to have_content('Number of post: 6')
    end

    it 'displays post information' do
      expect(page).to have_content('Post Three')
      expect(page).to have_content('three: post text')
      expect(page).to have_content('comment one')
      expect(page).to have_content('Likes: 0')
      expect(page).to have_content('Comments: 6')
    end

    it 'displays only the first 5 posts (pagination)' do
      expect(page).not_to have_content('Post One')
    end

    it 'redirects to the post when clicked' do
      visit user_path(@user_peter)
      click_link @post3.title

      expect(current_path).to eq(user_post_path(@user_peter, @post3))
    end

    after(:each) do
      User.destroy_all
    end
  end
end
