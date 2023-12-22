require 'rails_helper'

RSpec.describe 'Posts controller', type: :request do
  describe 'GET /users/user_id/posts' do
    before do
      user = User.create(name: 'Ben')
      get user_posts_path(user)

      def current_user
        user = User.find_by(name: 'Ben')
      end
    end

    it 'returns a 200 status code' do
      expect(response).to have_http_status(200)
    end

    it "renders the 'index' template" do
      expect(response).to render_template('index')
    end

    it "includes 'All posts by User' in the response body" do
      expect(response.body).to include("Number of post: #{current_user.posts_counter}")
    end
  end

  describe 'GET /users/user_id/posts/post_id' do
    before do
      user = User.create(name: 'Tom')
      post = user.posts.create(title: 'test post', text: 'test post body')
      get user_post_path(user, post)
    end

    it 'returns a 200 status code' do
      expect(response).to have_http_status(200)
    end

    it "renders the 'show' template" do
      expect(response).to render_template('show')
    end

    it "includes 'Specific post by a Specific User' in the response body" do
      expect(response.body).to include('test post')
    end
  end
end
