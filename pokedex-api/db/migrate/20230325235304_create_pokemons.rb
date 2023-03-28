class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.integer :number
      t.string :name
      t.string :first_type
      t.string :second_type
      t.integer :total
      t.integer :hp
      t.integer :attack
      t.integer :defense
      t.integer :sp_attack
      t.integer :sp_defense
      t.integer :speed
      t.integer :generation
      t.boolean :legendary

      t.timestamps
    end
  end
end
