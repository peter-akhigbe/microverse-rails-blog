require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many posts' do
      user = User.create(name: 'John Doe')
      3.times { user.posts.create(title: 'Test Post') }
      expect(user.posts.count).to eq(3)
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      user = User.create(name: '')
      expect(user.errors[:name]).to include("can't be blank")
    end
  end

  describe '#recent_posts' do
    it 'returns the most recent posts' do
      user = User.create(name: 'John Doe')
      3.times { |i| user.posts.create(title: "Post #{i}") }

      recent_posts = user.recent_posts
      expect(recent_posts.count).to eq(3)
      expect(recent_posts.first.title).to eq('Post 2')
    end

    it 'limits the number of posts returned' do
      user = User.create(name: 'John Doe')
      5.times { |i| user.posts.create(title: "Post #{i}") }

      recent_posts = user.recent_posts(2)
      expect(recent_posts.count).to eq(2)
      expect(recent_posts.first.title).to eq('Post 4')
    end
  end
end
