RSpec.describe Post, type: :model do
  describe 'associations' do
    it 'belongs to an author' do
      user = User.create(name: 'John Doe')
      post = Post.create(title: 'My First Post', author_id: user.id)
      expect(post.author).to eq(user)
    end
  end

  describe 'validations' do
    it 'validates presence of title' do
      post = Post.create(title: '')
      expect(post.errors[:title]).to include("can't be blank")
    end
  end

  describe '#update_user_posts_counter' do
    it 'updates the user\'s posts_counter attribute after saving a post' do
      user = User.create(name: 'John Doe')
      Post.create(title: 'My First Post', author: user)

      expect(user.posts_counter).to eq(1)
    end
  end
end
