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

ActiveRecord::Schema.define(version: 20161022134212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annotations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "related_tags", default: [],              array: true
  end

  create_table "annotations_documents", id: false, force: :cascade do |t|
    t.integer "annotation_id"
    t.integer "document_id"
  end

  add_index "annotations_documents", ["annotation_id", "document_id"], name: "index_annotations_documents_on_annotation_id_and_document_id", using: :btree

  create_table "annotations_users", id: false, force: :cascade do |t|
    t.integer "annotation_id"
    t.integer "user_id"
  end

  add_index "annotations_users", ["annotation_id", "user_id"], name: "index_annotations_users_on_annotation_id_and_user_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "url"
    t.text     "description"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "documents_users", id: false, force: :cascade do |t|
    t.integer "document_id"
    t.integer "user_id"
  end

  add_index "documents_users", ["document_id", "user_id"], name: "index_documents_users_on_document_id_and_user_id", using: :btree

  create_table "tweets", force: :cascade do |t|
    t.string   "uri"
    t.text     "text"
    t.string   "expanded_url"
    t.string   "display_url"
    t.string   "url"
    t.string   "user_name"
    t.string   "lang"
    t.string   "geo"
    t.string   "source"
    t.integer  "original_tweet_id", limit: 8
    t.datetime "tweet_created_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "full_name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
