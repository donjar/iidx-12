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

ActiveRecord::Schema.define(version: 20160717171553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charts", force: :cascade do |t|
    t.integer  "songid"
    t.string   "diff"
    t.integer  "notes"
    t.string   "title"
    t.integer  "version"
    t.integer  "clear"
    t.integer  "score"
    t.integer  "miss"
    t.integer  "nc_level"
    t.integer  "hc_level"
    t.integer  "target_clear"
    t.integer  "target_priority"
    t.string   "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "just_updated"
    t.boolean  "nc_gimmicks"
    t.boolean  "hc_gimmicks"
  end

end
