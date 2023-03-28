require 'rails_helper'

describe 'Users API', type: :request do
  describe 'GET /users' do
    before do
      FactoryBot.create(:user, name: ENV['USER_NAME'], user_role: ENV['USER_ROLE'], user_id: ENV['USER_ID'], role_id: ENV['USER_ROLE_ID'], password_digest: ENV['PASSWORD_DIGEST'])
    end

    it 'returns all users' do
      get '/api/v1/users'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /user' do
    it 'creates a new user' do
      expect {
        post '/api/v1/users', params: { user: { name: ENV['USER_NAME'], user_role: ENV['USER_ROLE'], user_id: ENV['USER_ID'], role_id: ENV['USER_ROLE_ID'], password_digest: ENV['PASSWORD_DIGEST'] } }
      }.to change { User.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'Get /users/:id' do
    let!(:user) { FactoryBot.create(:user, name: ENV['USER_NAME'], user_role: ENV['USER_ROLE'], user_id: ENV['USER_ID'], role_id: ENV['USER_ROLE_ID'], password_digest: ENV['PASSWORD_DIGEST']) }

    it 'returns a specific user' do
      get "/api/v1/users/#{user.id}/"

      expect(response).to have_http_status(:ok)
    end
  end
end
