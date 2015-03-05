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

ActiveRecord::Schema.define(version: 20150304194219) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "archivemsgs", force: :cascade do |t|
    t.text     "text_msg",       limit: 65535
    t.string   "physician_name", limit: 255
    t.string   "patient_name",   limit: 255
    t.integer  "physician",      limit: 4
    t.integer  "patient",        limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "diseasecodes", force: :cascade do |t|
    t.string   "disease",          limit: 255
    t.string   "code",             limit: 255
    t.integer  "hospitaladmin_id", limit: 4
    t.text     "description",      limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "name",                   limit: 255
    t.string   "emp_id",                 limit: 255
    t.integer  "hospitaladmin_id",       limit: 4
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "doctors", ["email"], name: "index_doctors_on_email", unique: true, using: :btree
  add_index "doctors", ["reset_password_token"], name: "index_doctors_on_reset_password_token", unique: true, using: :btree

  create_table "hospitaladmins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hospitaladmins", ["email"], name: "index_hospitaladmins_on_email", unique: true, using: :btree
  add_index "hospitaladmins", ["reset_password_token"], name: "index_hospitaladmins_on_reset_password_token", unique: true, using: :btree

  create_table "patientdiseases", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.string   "disease",    limit: 255
    t.integer  "patient_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "patientdiseases", ["patient_id"], name: "index_patientdiseases_on_patient_id", using: :btree

  create_table "patientmsgs", force: :cascade do |t|
    t.text     "text_msg",   limit: 65535
    t.integer  "physician",  limit: 4
    t.integer  "patient_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "patientmsgs", ["patient_id"], name: "index_patientmsgs_on_patient_id", using: :btree

  create_table "patients", force: :cascade do |t|
    t.string   "first_name",       limit: 255
    t.string   "last_name",        limit: 255
    t.string   "mi",               limit: 255
    t.string   "email",            limit: 255
    t.integer  "hospitaladmin_id", limit: 4
    t.string   "gender",           limit: 255
    t.string   "date_of_birth",    limit: 255
    t.string   "contact_no",       limit: 255
    t.string   "billing_id",       limit: 255
    t.integer  "discharge_status", limit: 4
    t.string   "physician",        limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "photomsgs", force: :cascade do |t|
    t.integer  "physician",          limit: 4
    t.integer  "patient",            limit: 4
    t.string   "title",              limit: 255
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_foreign_key "patientdiseases", "patients"
  add_foreign_key "patientmsgs", "patients"
end
