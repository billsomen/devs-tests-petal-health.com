class Api::V1::PokemonsController < ApplicationController
  def update
    if @pokemon
      @pokemon.update(poke_params)
      render json: { message: 'Pokemon Record Updated Successfully' }, status: :ok
    else
      render json: { error: 'Pokemon Not Found' }, status: :not_found
    end
  end
end