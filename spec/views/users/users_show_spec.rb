require 'rails_helper'

RSpec.describe 'User', type: :feature do
  describe 'content of user index page' do
    let(:user) { User.create(name: 'Peter', photo: 'photo_url_peter', bio: 'This is Peter') }

    before(:each) do
      visit "/users/#{user.id}"
    end

    it 'shows the username' do
      expect(page).to have_content(user.name)
    end

    it 'should show users photo' do
      expect(page).to have_css("img[src='#{user.photo}']")
    end

    it 'should display user name' do
      expect(page).to have_content(user.name)
    end

    it 'should display the number of posts' do
      expect(page).to have_content("Number of post: #{user.posts.count}")
    end

    it 'should display user bio' do
      expect(page).to have_content(user.bio)
    end

    it 'should display see all post link' do
      expect(page).to have_content('See all posts')
    end

    it 'redirects to the specific post when the user clicks on it' do
      post = user.posts.create(title: 'Post #1', text: 'This is the first post')

      visit user_path(user)
      click_link post.title

      sleep 10
      expect(current_path).to eq(user_post_path(user, post))
    end

    it 'redirects to the user show page to see all posts' do
      visit user_path(user)
      click_link('See all posts')

      sleep(10)
      expect(current_path).to eq(users_path)
    end
  end
end
