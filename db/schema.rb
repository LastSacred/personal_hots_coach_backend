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

ActiveRecord::Schema.define(version: 2019_04_11_131652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hero_picks", force: :cascade do |t|
    t.string "picked_by"
    t.integer "team"
    t.bigint "match_id"
    t.bigint "hero_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "win"
    t.index ["hero_id"], name: "index_hero_picks_on_hero_id"
    t.index ["match_id"], name: "index_hero_picks_on_match_id"
  end

  create_table "heroes", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon_url"
  end

  create_table "maps", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "replay_id"
    t.string "game_date"
    t.string "original_path"
    t.string "game_type"
    t.bigint "map_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "complete", default: false
    t.index ["map_id"], name: "index_matches_on_map_id"
  end

  create_table "replay_files", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.bigint "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_replay_files_on_match_id"
    t.index ["user_id"], name: "index_replay_files_on_user_id"
  end

  create_table "roster_listings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "hero_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hero_id"], name: "index_roster_listings_on_hero_id"
    t.index ["user_id"], name: "index_roster_listings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "battletag"
    t.string "replay_path"
    t.boolean "auto_roster", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "track_quick_match", default: false
    t.boolean "track_unranked_draft", default: true
    t.boolean "track_ranked_draft", default: true
  end

  add_foreign_key "hero_picks", "heroes"
  add_foreign_key "hero_picks", "matches"
  add_foreign_key "matches", "maps"
  add_foreign_key "replay_files", "matches"
  add_foreign_key "replay_files", "users"
  add_foreign_key "roster_listings", "heroes"
  add_foreign_key "roster_listings", "users"
end
