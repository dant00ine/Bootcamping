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

ActiveRecord::Schema.define(version: 20151125044816) do

  create_table "bootcamps", force: :cascade do |t|
    t.string   "title"
    t.text     "about"
    t.string   "image"
    t.string   "speciality"
    t.string   "location"
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

  create_table "dev_statuses", force: :cascade do |t|
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "profile_id"
    t.integer  "bootcamp_id"
  end

  create_table "professions", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "nick_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "contact_website"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.string   "image"
    t.integer  "profession_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "status"
    t.integer  "statusable_id"
    t.string   "statusable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "statuses", ["statusable_id"], name: "index_statuses_on_statusable_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "remember_digest"
  end

end
