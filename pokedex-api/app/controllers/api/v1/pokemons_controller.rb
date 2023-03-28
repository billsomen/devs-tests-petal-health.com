class Api::V1::PokemonsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  before_action :set_pokemon, only: [:show, :update, :destroy]
  before_action :authorize_request, except: [:index, :show]
  # TODO: apply caching of 2 seconds for each request

  TOKEN = ENV['JWT_TOKEN']

  require_relative './pokemons_controllers/pokemons_index'
  require_relative './pokemons_controllers/pokemons_show'
  require_relative './pokemons_controllers/pokemons_create'
  require_relative './pokemons_controllers/pokemons_update'
  require_relative './pokemons_controllers/pokemons_destroy'

  private

  def set_pokemon
    @pokemon = Pokemon.find_by(id: params[:id])

  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Pokemon not found' }, status: :not_found
  end

  def poke_params
    params.require(:pokemon).permit([
      :number,
      :name,
      :first_type,
      :second_type,
      :total,
      :hp,
      :attack,
      :defense,
      :sp_attack,
      :sp_defense,
      :speed,
      :generation,
      :legendary
    ])
  end

  def should_send_link(condition, page)
    condition ? api_v1_pokemons_path(page: page, limit: params[:limit]) : nil
  end

  private
  
  def authorize_request
    authenticate_or_request_with_http_token do |token, options|
      decoded = JsonWebToken.decode(token)
      @current_user = User.find_by_user_id(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end