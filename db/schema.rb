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

ActiveRecord::Schema.define(version: 20160922002553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listeners", force: :cascade do |t|
    t.string   "name"
    t.jsonb    "search_terms", default: {"keywords"=>[], "key_hashtags"=>[], "key_mentions"=>[]}
    t.jsonb    "options",      default: {"hashtags"=>false, "mentions"=>false, "case_sensitive"=>true, "include_replies"=>true, "use_keywords_everywhere"=>false}
    t.datetime "created_at",                                                                                                                                       null: false
    t.datetime "updated_at",                                                                                                                                       null: false
    t.index ["search_terms"], name: "index_listeners_on_search_terms", using: :gin
  end

  create_table "slips", force: :cascade do |t|
    t.string   "name"
    t.jsonb    "slips",       default: {"hashtags"=>[], "keywords"=>[], "mentions"=>[]}
    t.integer  "listener_id"
    t.bigint   "tweet_id"
    t.string   "author"
    t.string   "body"
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "screen_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
