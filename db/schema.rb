# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140506093552) do

  create_table "frames", force: true do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "frames", ["game_id"], name: "index_frames_on_game_id"
  add_index "frames", ["player_id"], name: "index_frames_on_player_id"

  create_table "games", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games_players", id: false, force: true do |t|
    t.integer "game_id",   null: false
    t.integer "player_id", null: false
  end

  add_index "games_players", ["game_id"], name: "index_games_players_on_game_id"
  add_index "games_players", ["player_id"], name: "index_games_players_on_player_id"

  create_table "players", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rolls", force: true do |t|
    t.integer  "frame_id"
    t.integer  "pins"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rolls", ["frame_id"], name: "index_rolls_on_frame_id"

end
