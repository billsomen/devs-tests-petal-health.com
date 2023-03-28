require 'csv'
require 'sqlite3'

class UserSeeder
  def self.seed
    User.create(
      name: ENV['USER_NAME'],
      user_role: ENV['USER_ROLE'],
      user_id: ENV['USER_ID'],
      role_id: ENV['USER_ROLE_ID'],
      password_digest: ENV['PASSWORD_DIGEST'],
    )
  end
end

class PokemonSeeder
  BATCH_SIZE = 1000

  def self.seed
    db = SQLite3::Database.new 'db/development.sqlite3'
    db.execute 'BEGIN TRANSACTION'

    insert_stmt = db.prepare <<-SQL
      INSERT INTO 'pokemons' (number, name, first_type, second_type, total, hp, attack, defense, sp_attack, sp_defense, speed, generation, legendary, created_at, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    SQL

    begin
      CSV.foreach('data/pokemon.csv', headers: true, encoding: 'UTF-8') do |row|
        values = [
          row['#'], 
          row['Name'], 
          row['Type 1'], 
          row['Type 2'], 
          row['Total'], 
          row['HP'], 
          row['Attack'], 
          row['Defense'], 
          row['Sp. Atk'], 
          row['Sp. Def'], 
          row['Speed'], 
          row['Generation'], 
          row['Legendary'],
          DateTime.now.strftime('%F %T'),
          DateTime.now.strftime('%F %T'),
        ]
        insert_stmt.execute(values)

        if db.changes % BATCH_SIZE == 0
          db.execute 'COMMIT'
          db.execute 'BEGIN TRANSACTION'
        end
      end

      db.execute 'COMMIT'

    rescue SQLite3::Exception => e
      puts "Exception occurred: #{e}"
      db.execute 'ROLLBACK'
    ensure
      insert_stmt.close
      db.close
    end
  end
end

begin
  UserSeeder.seed
  PokemonSeeder.seed
end