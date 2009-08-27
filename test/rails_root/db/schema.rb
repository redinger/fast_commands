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

ActiveRecord::Schema.define(:version => 20090827202238) do

  create_table "commands", :force => true do |t|
    t.integer  "device_id"
    t.string   "command",         :limit => 100
    t.string   "response",        :limit => 100
    t.string   "status",          :limit => 100, :default => "Processing"
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.string   "transaction_id",  :limit => 25
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
