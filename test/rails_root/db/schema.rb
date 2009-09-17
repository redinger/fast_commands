# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 4) do

  create_table "available_command_params", :force => true do |t|
    t.integer  "available_command_id"
    t.string   "name"
    t.string   "label"
    t.string   "hint"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "available_command_params", ["available_command_id"], :name => "index_available_command_params_on_available_command_id"

  create_table "available_commands", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.string   "device_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "available_commands", ["device_type"], :name => "index_available_commands_on_device_type"

  create_table "commands", :force => true do |t|
    t.integer  "device_id"
    t.string   "command",         :limit => 100
    t.string   "response",        :limit => 100
    t.string   "status",          :limit => 100, :default => "Processing"
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.string   "transaction_id",  :limit => 25
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commands", ["device_id"], :name => "index_commands_on_device_id"

  create_table "devices", :force => true do |t|
    t.string   "name"
    t.string   "gateway_name"
    t.string   "imei"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
