require 'rails_helper'

RSpec.describe 'users', type: :feature do
  describe '#index' do
    before(:all) do
      @user1 = User.create(name: 'Peter', photo: 'photo_url_peter', bio: 'This is Peter')
      @user2 = User.create(name: 'Paul', photo: 'photo_url_paul', bio: 'This is Paul')
    end

    it 'shows all users' do
      visit users_path
      expect(page).to have_content('Peter')
      expect(page).to have_content('Paul')
    end

    it 'display the photos for each user' do
      visit users_path
      expect(page).to have_css("img[src*='photo_url_peter']")
      expect(page).to have_css("img[src*='photo_url_paul']")
    end

    it 'Display number of post' do
      visit users_path
      expect(page).to have_content('Number of post: 0')
    end

    it 'display number of posts for each user' do
      @post = Post.create(author_id: @user1.id, title: 'How to be a programmer', text: 'DoHardThings')
      visit users_path
      expect(page).to have_content('Number of post: 1')
    end

    it 'Redirect to that user\'s show page on clicking a user' do
      @user3 = User.create(name: 'John', photo: 'photo_url_john', bio: 'This is John')
      visit users_path
      click_link(@user3.name)
      expect(current_path).to eq(user_path(@user3))
    end

    after(:all) do
      @user1.destroy if @user1.present?
      @user2.destroy if @user2.present?
    end
  end
end
