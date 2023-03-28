class Rack::Attack  
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  throttle('get_pokemons', limit: 60, period: 1.minute) do |req|
    if req.path == '/api/v1/pokemons' && req.get?
      req.ip
    end
  end

  throttle('post_pokemonts', limit: 10, period: 20.seconds) do |req|
    if req.path == '/api/v1/pokemons' && req.post?
      req.ip
    end
  end

  throttle('update_pokemonts', limit: 1, period: 2.seconds) do |req|
    if req.path == '/api/v1/pokemons' && req.put?
      req.ip
    end
  end

  throttle('delete_pokemonts', limit: 1, period: 2.seconds) do |req|
    if req.path == '/api/v1/pokemons' && req.delete?
      req.ip
    end
  end
end