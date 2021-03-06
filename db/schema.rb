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

ActiveRecord::Schema.define(version: 20140429195845) do

  create_table "relationships", force: true do |t|
    t.integer  "friend_a_id"
    t.integer  "friend_b_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "friendship_status"
  end

  add_index "relationships", ["friend_a_id", "friend_b_id"], name: "index_relationships_on_friend_a_id_and_friend_b_id", unique: true
  add_index "relationships", ["friend_a_id"], name: "index_relationships_on_friend_a_id"
  add_index "relationships", ["friend_b_id"], name: "index_relationships_on_friend_b_id"

  create_table "userposts", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "userposts", ["user_id", "created_at"], name: "index_userposts_on_user_id_and_created_at"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "age"
    t.string   "gender"
    t.string   "ocupation"
    t.text     "books"
    t.text     "movies"
    t.text     "bands"
    t.string   "song"
    t.text     "hobbies"
    t.text     "about_me"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
