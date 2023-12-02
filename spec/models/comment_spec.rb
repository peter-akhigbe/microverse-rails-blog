require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(text: 'comment one') }
  before { subject.save }

  it 'should raise error without post' do
    expect { subject.comment_counter }.to raise_error(NoMethodError)
  end

  it 'should displays five recent comments when called' do
    post = Post.create(title: 'Sample Post', author: User.create(name: 'User'))

    comments = 6.times.map { |i| post.comments.create(text: "Comment #{i}", user: User.create(name: "User#{i}")) }

    post.reload

    expect(post.recent_comments.length).to eq(5)
    expect(post.recent_comments).to eq(comments.last(5).reverse)
  end
end
