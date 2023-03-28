# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Pokemons API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        schemas: {
          pokemon: {
            type: :object,
            properties: {
              id: { type: :integer },
              number: { type: :integer },
              name: { type: :string },
              first_type: { type: :string },
              second_type: { type: :string },
              total: { type: :integer },
              hp: { type: :integer },
              attack: { type: :integer },
              defense: { type: :integer },
              sp_attack: { type: :integer },
              sp_defense: { type: :integer },
              speed: { type: :integer },
              generation: { type: :integer },
              legendary: { type: :boolean },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            },
            required: %w[number name first_type total hp attack defense sp_attack sp_defense speed generation legendary]
          },
        },
        response: {
          message: {
            type: :object,
            properties: { message: { type: :string } },
            required: %w[message]
          },
          error: {
            type: :object,
            properties: { error: { type: :string } },
            required: %w[error]
          }
        },
        example: {
          post_pokemon: {
            type: :object,
            properties: {
              number: { type: :integer, default: 25 },
              name: { type: :string, default: 'Pikachu' },
              first_type: { type: :string, default: 'Ellectric' },
              second_type: { type: :string, default: 'Volta' },
              total: { type: :integer, default: 320 },
              hp: { type: :integer, default: 35 },
              attack: { type: :integer, default: 55 },
              defense: { type: :integer, default: 40 },
              sp_attack: { type: :integer, default: 50 },
              sp_defense: { type: :integer, default: 50 },
              speed: { type: :integer, default: 90 },
              generation: { type: :integer, default: 1 },
              legendary: { type: :boolean, default: false },
            },
            required: %w[number name first_type total hp attack defense sp_attack sp_defense speed generation legendary]
          },
        },
        securitySchemes: {
          bearerAuth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: :JWT,
          },
        }
      },
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: '127.0.0.1:3000'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
