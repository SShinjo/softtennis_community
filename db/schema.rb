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

ActiveRecord::Schema.define(version: 2020_01_11_055230) do

  create_table "chats", force: :cascade do |t|
    t.integer "user_id"
    t.integer "room_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_chats_on_room_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "communities", force: :cascade do |t|
    t.string "name"
    t.text "introduction"
    t.date "date"
    t.time "time"
    t.string "place"
    t.integer "capacity"
    t.boolean "is_closed", default: false
    t.boolean "is_held", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer "user_id"
    t.integer "community_id"
    t.boolean "is_host", default: false
    t.boolean "is_member", default: false
    t.boolean "is_checked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_members_on_community_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_relationships_on_friend_id"
    t.index ["user_id", "friend_id"], name: "index_relationships_on_user_id_and_friend_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "community_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_rooms_on_community_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.text "introduction"
    t.string "image_id"
    t.integer "position", default: 4
    t.integer "level", default: 4
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
