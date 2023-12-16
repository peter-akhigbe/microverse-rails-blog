require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before do
      get users_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text' do
      expect(response.body).to include('Home')
    end
  end

  describe 'GET /show' do
    let(:user) { User.create!(name: 'Test User', posts_counter: 0) }

    before do
      get user_path(user)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text' do
      expect(response.body).to include('Test User')
    end
  end
end
