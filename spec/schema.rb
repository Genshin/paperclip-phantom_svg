ActiveRecord::Schema.define :version => 0 do
  create_table "phantom", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_name"
    t.integer  "file_size"
    t.datetime "original_updated_at"
  end
end
