require 'swagger_helper'
require 'rails_helper'

describe 'Pokemons API' do
  TOKEN = ENV['JWT_TOKEN']

  path '/api/v1/pokemons' do
    get 'Retrieves all Pokemons' do
      tags 'Pokemons'
      produces 'application/json'
      parameter name: :page, in: :query, type: :integer, description: 'Page number'
      parameter name: :limit, in: :query, type: :integer, description: 'Number of Pokemons per page'

      response '200', 'OK' do
        schema type: :object,
          properties: {
            pokemon: {
              type: :array,
              items: {
                '$ref': '#/components/schemas/pokemon'
              }
            },
            page: { type: :integer },
            page_count: { type: :integer },
            total_count: { type: :integer },
            last_page: { type: [:string, :null ]},
            next_page: { type: [:string, :null ] },
            prev_page: { type: [:string, :null ] }
          },
          required: [:pokemons, :page, :total_count, :last_page, :next_page, :prev_page]

        let(:page) { 1 }
        let(:limit) { 10 }

        run_test!
      end
    end
  end

  path '/api/v1/pokemons/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a specific pokemon' do
      tags 'Pokemons'
      produces 'application/json'

      response '200', 'pokemon found' do
        schema '$ref': '#/components/schemas/pokemon'

        let!(:pokemon) { FactoryBot.create(:pokemon, id: 1, number: 1, name: 'Bulbasaur', first_type: 'Grass', second_type: 'Poison', total: 318,  hp: 45, attack: 49, defense: 49, sp_attack: 65, sp_defense: 65, speed: 45, generation: 1, legendary: false) }
        let(:id) { pokemon.id }

        run_test!
      end

      response '404', 'pokemon not found' do
        schema '$ref': '#/components/response/error'

        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/pokemons' do
    post 'Creates a new Pokemon' do
      tags 'Pokemons'
      consumes 'application/json'
      security [ bearerAuth: [] ]
      parameter name: :pokemon, in: :body, schema: { '$ref': '#/components/example/post_pokemon' }
  
      response '201', 'Created' do
        schema '$ref': '#/components/schemas/pokemon'

        before do
          FactoryBot.create(:user, name: ENV['USER_NAME'], user_role: ENV['USER_ROLE'], user_id: ENV['USER_ID'], role_id: ENV['USER_ROLE_ID'], password_digest: ENV['PASSWORD_DIGEST'])
        end
  
        let(:Authorization) { "Bearer #{TOKEN}" }
        let(:pokemon) do
          {
            number: 25,
            name: 'Pikachu',
            first_type: 'Electric',
            second_type: '',
            total: 320,
            hp: 35,
            attack: 55,
            defense: 40,
            sp_attack: 50,
            sp_defense: 50,
            speed: 90,
            generation: 1,
            legendary: false
          }
        end
  
        run_test!
      end
    end
  end

  path '/api/v1/pokemons/{id}' do
    let(:Authorization) { "Bearer #{TOKEN}" }

    delete 'Deletes a Pokemon' do
      tags 'Pokemons'
      consumes 'application/json'
      security [ bearerAuth: [] ]
      parameter name: :id, in: :path, type: :integer
  
      response '204', 'No Content' do

        before do
          FactoryBot.create(:user, name: ENV['USER_NAME'], user_role: ENV['USER_ROLE'], user_id: ENV['USER_ID'], role_id: ENV['USER_ROLE_ID'], password_digest: ENV['PASSWORD_DIGEST'])
        end
        
        let(:Authorization) { "Bearer #{TOKEN}" }
        let(:id) { FactoryBot.create(:pokemon).id }
  
        run_test!
      end
  
      response '404', 'Not Found' do
        schema '$ref': '#/components/response/error'
        before do
          FactoryBot.create(:user, name: ENV['USER_NAME'], user_role: ENV['USER_ROLE'], user_id: ENV['USER_ID'], role_id: ENV['USER_ROLE_ID'], password_digest: ENV['PASSWORD_DIGEST'])
        end

        let(:Authorization) { "Bearer #{TOKEN}" }
        let(:id) { 'invalid' }
  
        run_test!
      end
    end
  end

  path '/api/v1/pokemons/{id}' do
    put 'Updates a specific Pokemon' do
      tags 'Pokemons'
      consumes 'application/json'
      produces 'application/json'
      security [ bearerAuth: [] ]
      parameter name: :id, in: :path, type: :integer
      parameter name: :pokemon, in: :body, schema: { '$ref': '#/components/example/post_pokemon' }

      response '200', 'OK' do
        schema '$ref': '#/components/response/message'
        before do
          FactoryBot.create(:user, name: ENV['USER_NAME'], user_role: ENV['USER_ROLE'], user_id: ENV['USER_ID'], role_id: ENV['USER_ROLE_ID'], password_digest: ENV['PASSWORD_DIGEST'])
        end

        let(:Authorization) { "Bearer #{TOKEN}" }
        let!(:pokemon) { FactoryBot.create(:pokemon, id: 1, number: 1, name: 'Bulbasaur', first_type: 'Grass', second_type: 'Poison', total: 318,  hp: 45, attack: 49, defense: 49, sp_attack: 65, sp_defense: 65, speed: 45, generation: 1, legendary: false) }
        let(:id) { pokemon.id }
        run_test!
      end

      response '404', 'Not Found' do
        schema '$ref': '#/components/response/error'
        before do
          FactoryBot.create(:user, name: ENV['USER_NAME'], user_role: ENV['USER_ROLE'], user_id: ENV['USER_ID'], role_id: ENV['USER_ROLE_ID'], password_digest: ENV['PASSWORD_DIGEST'])
        end

        let(:Authorization) { "Bearer #{TOKEN}" }
        let(:id) { 'invalid' }
        let(:pokemon) { { number: 25, name: 'Pikachu', first_type: 'Electric', second_type: '', total: 320,  hp: 35, attack: 55, defense: 40, sp_attack: 50, sp_defense: 50, speed: 90, generation: 1, legendary: false } }
        run_test!
      end
    end
  end
end