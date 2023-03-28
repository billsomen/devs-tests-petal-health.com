class Api::V1::PokemonsController < ApplicationController
  def show
    if @pokemon
      render json: @pokemon, status: :ok
    else
      render json: { error: 'Pokemon Not Found' }, status: :not_found
    end
  end
end