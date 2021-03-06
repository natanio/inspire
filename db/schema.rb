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

ActiveRecord::Schema.define(version: 20141006041548) do

  create_table "books", force: true do |t|
    t.string   "title"
    t.text     "link"
    t.string   "genre"
    t.text     "description"
    t.string   "date_publish"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "preview"
    t.integer  "inspiration_id"
    t.string   "isbn"
    t.string   "aws_image_url"
    t.string   "url"
  end

  add_index "books", ["user_id"], name: "index_books_on_user_id"

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "inspiration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "favorited_id"
    t.string   "favorited_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["favorited_id", "favorited_type"], name: "index_favorites_on_favorited_id_and_favorited_type"
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"

  create_table "inspirations", force: true do |t|
    t.text     "quote",       limit: 500
    t.integer  "page_number"
    t.integer  "likes",                   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "book_id"
  end

  add_index "inspirations", ["quote"], name: "index_inspirations_on_quote", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                      default: "", null: false
    t.string   "encrypted_password",         default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "admin"
    t.string   "profile_image_file_name"
    t.string   "profile_image_content_type"
    t.integer  "profile_image_file_size"
    t.datetime "profile_image_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: true do |t|
    t.integer  "value"
    t.integer  "user_id"
    t.integer  "inspiration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["inspiration_id"], name: "index_votes_on_inspiration_id"
  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

end
