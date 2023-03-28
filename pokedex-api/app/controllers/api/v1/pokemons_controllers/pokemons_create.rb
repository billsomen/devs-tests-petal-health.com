class Api::V1::PokemonsController < ApplicationController
  def create
    pokemon = Pokemon.new(poke_params)
    if pokemon.save
      render json: pokemon, status: :created
    else
      render  json: { error: 'Error Creating Pokemon' }, 
              status: :error
    end
  end
end