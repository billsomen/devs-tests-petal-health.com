# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_27_172027) do
  create_table "pokemons", force: :cascade do |t|
    t.integer "number"
    t.string "name"
    t.string "first_type"
    t.string "second_type"
    t.integer "total"
    t.integer "hp"
    t.integer "attack"
    t.integer "defense"
    t.integer "sp_attack"
    t.integer "sp_defense"
    t.integer "speed"
    t.integer "generation"
    t.boolean "legendary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "user_role"
    t.string "user_id"
    t.string "role_id"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
