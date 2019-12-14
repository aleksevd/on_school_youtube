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

ActiveRecord::Schema.define(version: 20180929125156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "answer_images", force: :cascade do |t|
    t.bigint "answer_id"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_answer_images_on_answer_id"
  end

  create_table "answers", force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type"
    t.bigint "user_lesson_id"
    t.string "audio"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "viewed", default: false, null: false
    t.index ["owner_id", "owner_type"], name: "index_answers_on_owner_id_and_owner_type"
    t.index ["user_lesson_id"], name: "index_answers_on_user_lesson_id"
    t.index ["viewed"], name: "index_answers_on_viewed"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "main_image"
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "discipline_courses", force: :cascade do |t|
    t.bigint "discipline_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_discipline_courses_on_course_id"
    t.index ["discipline_id"], name: "index_discipline_courses_on_discipline_id"
  end

  create_table "disciplines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flows", force: :cascade do |t|
    t.bigint "course_id"
    t.string "state"
    t.datetime "starts_at"
    t.datetime "checks_finish_at"
    t.datetime "finishes_at"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_flows_on_course_id"
    t.index ["state"], name: "index_flows_on_state"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "course_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "section_id"
    t.string "main_image"
    t.boolean "stop_lesson"
    t.text "video"
    t.text "homework"
    t.boolean "without_homework"
    t.boolean "free", default: false, null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
    t.index ["free"], name: "index_lessons_on_free", where: "(free = true)"
    t.index ["position"], name: "index_lessons_on_position"
    t.index ["section_id"], name: "index_lessons_on_section_id"
    t.index ["stop_lesson"], name: "index_lessons_on_stop_lesson", where: "(stop_lesson = true)"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["course_id"], name: "index_sections_on_course_id"
    t.index ["position"], name: "index_sections_on_position"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
  end

  create_table "tinymce_images", force: :cascade do |t|
    t.string "file"
    t.string "owner_type"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_tinymce_images_on_owner_type_and_owner_id"
  end

  create_table "user_courses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "flow_id"
    t.boolean "paid", default: false, null: false
    t.string "state"
    t.index ["course_id", "user_id"], name: "index_user_courses_on_course_id_and_user_id", unique: true
    t.index ["course_id"], name: "index_user_courses_on_course_id"
    t.index ["flow_id"], name: "index_user_courses_on_flow_id"
    t.index ["state"], name: "index_user_courses_on_state"
    t.index ["user_id"], name: "index_user_courses_on_user_id"
  end

  create_table "user_lessons", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_course_id"
    t.string "state"
    t.index ["lesson_id", "user_id"], name: "index_user_lessons_on_lesson_id_and_user_id", unique: true
    t.index ["lesson_id"], name: "index_user_lessons_on_lesson_id"
    t.index ["state"], name: "index_user_lessons_on_state"
    t.index ["user_course_id"], name: "index_user_lessons_on_user_course_id"
    t.index ["user_id"], name: "index_user_lessons_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answer_images", "answers"
  add_foreign_key "answers", "user_lessons"
  add_foreign_key "courses", "teachers"
  add_foreign_key "discipline_courses", "courses"
  add_foreign_key "discipline_courses", "disciplines"
  add_foreign_key "flows", "courses"
  add_foreign_key "lessons", "courses"
  add_foreign_key "lessons", "sections"
  add_foreign_key "sections", "courses"
  add_foreign_key "user_courses", "courses"
  add_foreign_key "user_courses", "users"
  add_foreign_key "user_lessons", "lessons"
  add_foreign_key "user_lessons", "user_courses"
  add_foreign_key "user_lessons", "users"
end
