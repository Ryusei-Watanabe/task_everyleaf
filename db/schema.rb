ActiveRecord::Schema.define(version: 2020_09_11_090230) do
  enable_extension "plpgsql"
  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.string "state"
    t.datetime "deadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_tasks_on_title"
  end

end
