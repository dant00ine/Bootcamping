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

ActiveRecord::Schema.define(version: 20151231031755) do

  create_table "bootcamp_reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "bootcamp_id"
    t.integer  "profile_id"
  end

  create_table "bootcamps", force: :cascade do |t|
    t.string   "title"
    t.text     "about"
    t.string   "image"
    t.string   "website"
    t.string   "email"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "job_guarantee"
    t.string   "job_assistance"
    t.string   "apprenticeship"
    t.string   "accreditation"
    t.string   "post_grad_resources"
    t.string   "housing"
    t.string   "visa_assistance"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "bootcamps_locations", id: false, force: :cascade do |t|
    t.integer "bootcamp_id"
    t.integer "location_id"
  end

  add_index "bootcamps_locations", ["bootcamp_id"], name: "index_bootcamps_locations_on_bootcamp_id"
  add_index "bootcamps_locations", ["location_id"], name: "index_bootcamps_locations_on_location_id"

  create_table "bootcamps_profiles", id: false, force: :cascade do |t|
    t.integer "profile_id"
    t.integer "bootcamp_id"
  end

  add_index "bootcamps_profiles", ["bootcamp_id"], name: "index_bootcamps_profiles_on_bootcamp_id"
  add_index "bootcamps_profiles", ["profile_id"], name: "index_bootcamps_profiles_on_profile_id"

  create_table "bootcamps_specialities", id: false, force: :cascade do |t|
    t.integer "bootcamp_id"
    t.integer "speciality_id"
  end

  add_index "bootcamps_specialities", ["bootcamp_id"], name: "index_bootcamps_specialities_on_bootcamp_id"
  add_index "bootcamps_specialities", ["speciality_id"], name: "index_bootcamps_specialities_on_speciality_id"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "links", force: :cascade do |t|
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "professions", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "contact_website"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.string   "image"
    t.integer  "profession_id"
    t.string   "contact_linkedin"
  end

  create_table "specialities", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
    t.string   "nick_name"
    t.boolean  "admin",           default: false
    t.string   "slug"
  end

  add_index "users", ["slug"], name: "index_users_on_slug", unique: true

end
