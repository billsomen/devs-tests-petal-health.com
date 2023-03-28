class Api::V1::PokemonsController < ApplicationController
  def destroy
    if @pokemon
      @pokemon.destroy
      render json: { message: 'Pokemon Record Has Been Deleted' }, status: :no_content
    else
      render json: { error: 'Pokemon Not Found' }, status: :not_found
    end
  end
end