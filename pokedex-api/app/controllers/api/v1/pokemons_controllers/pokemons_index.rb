class Api::V1::PokemonsController < ApplicationController
  def index
    pokemons = Pokemon.page(params[:page]).per(params[:limit])

    render json: {
      pokemons: pokemons,
      page: pokemons.current_page,
      page_count: pokemons.total_pages,
      total_count: pokemons.total_count,
      last_page: should_send_link(pokemons.total_pages > 1, pokemons.total_pages),
      next_page: should_send_link(pokemons.next_page.present?, pokemons.next_page),
      prev_page: should_send_link(pokemons.prev_page.present?, pokemons.prev_page),
    }, status: :ok
  end
end
