# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091007111337) do

  create_table "arbitrage_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "arbitrages", :force => true do |t|
    t.integer  "line1_id"
    t.integer  "line2_id"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "arbitrages", ["line1_id"], :name => "index_arbitrages_on_line1_id"
  add_index "arbitrages", ["line2_id"], :name => "index_arbitrages_on_line2_id"
  add_index "arbitrages", ["type_id"], :name => "index_arbitrages_on_type_id"

  create_table "betting_sites", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "affiliate_code"
    t.string   "website_link"
    t.boolean  "active",         :default => false
    t.string   "class_name"
    t.boolean  "xml_feed"
    t.integer  "sleep_time"
  end

  create_table "contacts", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.datetime "game_time"
    t.integer  "sport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team1_score"
    t.integer  "team2_score"
    t.integer  "draw_id",     :default => 0
  end

  add_index "games", ["game_time"], :name => "game_time_idx"
  add_index "games", ["sport_id"], :name => "sport_idx"
  add_index "games", ["team1_id"], :name => "team1_idx"
  add_index "games", ["team2_id"], :name => "team2_idx"

  create_table "lines", :force => true do |t|
    t.integer  "team_id"
    t.integer  "game_id"
    t.integer  "betting_site_id"
    t.float    "spread"
    t.float    "spread_vig"
    t.float    "money_line"
    t.string   "over_under"
    t.float    "total_points"
    t.float    "total_points_vig"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lines", ["betting_site_id"], :name => "betting_site_idx"
  add_index "lines", ["game_id", "team_id", "betting_site_id"], :name => "game_team_site_idx"
  add_index "lines", ["game_id"], :name => "game_idx"
  add_index "lines", ["team_id"], :name => "name_idx"

  create_table "pages", :force => true do |t|
    t.string   "url"
    t.integer  "betting_site_id"
    t.integer  "sport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",          :default => false
  end

  add_index "pages", ["betting_site_id"], :name => "betting_site_idx"
  add_index "pages", ["sport_id"], :name => "sport_idx"

  create_table "past_lines", :force => true do |t|
    t.integer  "team_id"
    t.integer  "game_id"
    t.integer  "betting_site_id"
    t.float    "spread"
    t.float    "spread_vig"
    t.float    "money_line"
    t.string   "over_under"
    t.float    "total_points"
    t.float    "total_points_vig"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "past_lines", ["betting_site_id"], :name => "index_past_lines_on_betting_site_id"
  add_index "past_lines", ["game_id"], :name => "index_past_lines_on_game_id"
  add_index "past_lines", ["team_id"], :name => "index_past_lines_on_team_id"

  create_table "referals", :force => true do |t|
    t.integer  "betting_site_id"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_synonyms", :force => true do |t|
    t.string   "synonym"
    t.integer  "team_id"
    t.integer  "sport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "sport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["name"], :name => "name_idx"
  add_index "teams", ["sport_id"], :name => "sport_idx"

  create_table "unknown_teams", :force => true do |t|
    t.string   "name"
    t.integer  "sport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hide",       :default => false
  end

  create_table "user_betting_sites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "betting_site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_betting_sites", ["betting_site_id"], :name => "index_user_betting_sites_on_betting_site_id"
  add_index "user_betting_sites", ["user_id"], :name => "index_user_betting_sites_on_user_id"

  create_table "user_teams", :force => true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_teams", ["team_id"], :name => "index_user_teams_on_team_id"
  add_index "user_teams", ["user_id"], :name => "index_user_teams_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.boolean  "admin",                                    :default => false
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
