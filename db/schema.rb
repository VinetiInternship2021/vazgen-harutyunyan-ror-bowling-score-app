# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_28_001939) do

  create_table "frames", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "frame"
    t.integer "knocked_pins"
    t.integer "turn"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_frames_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "session_id", null: false
    t.integer "score"
    t.boolean "session_winner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_players_on_session_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "players_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "frames", "players", on_delete: :cascade
  add_foreign_key "players", "sessions", on_delete: :cascade
end
