require 'rails_helper'

describe 'Pokemons API', type: :request do
  token = ENV['JWT_TOKEN']

  describe 'GET /pokemons' do
    before do
      FactoryBot.create :pokemon, number: 1, name: 'Bulbasaur', first_type: 'Grass', second_type: 'Poison', total: 318,  hp: 45, attack: 49, defense: 49, sp_attack: 65, sp_defense: 65, speed: 45, generation: 1, legendary: false
      FactoryBot.create :pokemon, number: 2, name: 'Ivysaur', first_type: 'Grass', second_type: 'Poison', total: 405,  hp: 60, attack: 62, defense: 63, sp_attack: 80, sp_defense: 80, speed: 62, generation: 1, legendary: false
    end

    it 'returns all Pokemons' do
      get '/api/v1/pokemons'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['pokemons'].size).to eq(2)
      expect(JSON.parse(response.body)['page']).to eq(1)
      expect(JSON.parse(response.body)['total_count']).to eq(2)
    end
  end

  describe 'POST /pokemons' do
    before do
      FactoryBot.create(:user, name: ENV['USER_NAME'], user_role: ENV['USER_ROLE'], user_id: ENV['USER_ID'], role_id: ENV['USER_ROLE_ID'], password_digest: ENV['PASSWORD_DIGEST'])
    end

    it 'creates a new pokemon' do
      expect {
        post '/api/v1/pokemons', params: { pokemon: { number: 25, name: 'Pikachu', first_type: 'Electric', second_type: '', total: 320,  hp: 35, attack: 55, defense: 40, sp_attack: 50, sp_defense: 50, speed: 90, generation: 1, legendary: false } },
        headers: { 'Authorization' => "Bearer #{token}" }
      }.to change { Pokemon.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'Delete /pokemons/:id' do
    before do
      FactoryBot.create(:user, name: ENV['USER_NAME'], user_role: ENV['USER_ROLE'], user_id: ENV['USER_ID'], role_id: ENV['USER_ROLE_ID'], password_digest: ENV['PASSWORD_DIGEST'])
    end
    let!(:pokemon) { FactoryBot.create(:pokemon, number: 1, name: 'Bulbasaur', first_type: 'Grass', second_type: 'Poison', total: 318,  hp: 45, attack: 49, defense: 49, sp_attack: 65, sp_defense: 65, speed: 45, generation: 1, legendary: false) }

    it 'deletes a pokemon' do
      expect {
        delete "/api/v1/pokemons/#{pokemon.id}/",
        headers: { 'Authorization' => "Bearer #{token}" }
      }.to change { Pokemon.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'Get /pokemons/:id' do
    before do
      FactoryBot.create(:user, name: ENV['USER_NAME'], user_role: ENV['USER_ROLE'], user_id: ENV['USER_ID'], role_id: ENV['USER_ROLE_ID'], password_digest: ENV['PASSWORD_DIGEST'])
    end
    let!(:pokemon) { FactoryBot.create(:pokemon, number: 1, name: 'Bulbasaur', first_type: 'Grass', second_type: 'Poison', total: 318,  hp: 45, attack: 49, defense: 49, sp_attack: 65, sp_defense: 65, speed: 45, generation: 1, legendary: false) }

    it 'returns a specific pokemon' do
      get "/api/v1/pokemons/#{pokemon.id}/",
      headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq('Bulbasaur')
    end
  end

  describe 'PUT /pokemons/:id' do
    before do
      FactoryBot.create(:user, name: ENV['USER_NAME'], user_role: ENV['USER_ROLE'], user_id: ENV['USER_ID'], role_id: ENV['USER_ROLE_ID'], password_digest: ENV['PASSWORD_DIGEST'])
    end
    let!(:pokemon) { FactoryBot.create(:pokemon, number: 1, name: 'Bulbasaur', first_type: 'Grass', second_type: 'Poison', total: 318,  hp: 45, attack: 49, defense: 49, sp_attack: 65, sp_defense: 65, speed: 45, generation: 1, legendary: false) }

    it 'returns a specific pokemon' do
      put "/api/v1/pokemons/#{pokemon.id}/", params: { pokemon: { number: 25, name: 'Pikachu', first_type: 'Electric', second_type: '', total: 320,  hp: 35, attack: 55, defense: 40, sp_attack: 50, sp_defense: 50, speed: 90, generation: 1, legendary: false } },
      headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(:ok)
    end
  end
end
