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

ActiveRecord::Schema.define(version: 2022_05_18_135213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deliverers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.string "discord_token", null: false
    t.string "discord_channel_identifier", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_deliverers_on_user_id"
  end

  create_table "list_logs", force: :cascade do |t|
    t.integer "list_id"
    t.integer "tweet_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["list_id"], name: "index_list_logs_on_list_id"
    t.index ["tweet_id"], name: "index_list_logs_on_tweet_id"
  end

  create_table "lists", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", default: "", null: false
    t.string "list_identifier", default: "", null: false
    t.boolean "published", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lists_threshold", default: 50, null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "timeline_logs", force: :cascade do |t|
    t.integer "user_id"
    t.integer "tweet_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tweet_id"], name: "index_timeline_logs_on_tweet_id"
    t.index ["user_id"], name: "index_timeline_logs_on_user_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.string "tweet_id", null: false
    t.integer "favorite_count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_tweets_on_tweet_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "screen_name", null: false
    t.string "twitter_uid", null: false
    t.string "access_token"
    t.string "access_token_secret"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "timeline_published", default: false, null: false
    t.integer "favorite_threshold", default: 50, null: false
  end

end
