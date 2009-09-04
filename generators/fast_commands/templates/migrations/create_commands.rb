class FastCommandsCreateCommands < ActiveRecord::Migration
  def self.up
    create_table :commands do |t|
      t.references :device
      t.string :command, :limit => 100
      t.string :response, :limit => 100
      t.string :status, :limit => 100, :default => 'Processing'
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.string :transaction_id, :limit => 25
      t.timestamps
    end
    
    add_index :commands, :device_id
  end

  def self.down
    remove_index :commands, :device_id
    drop_table :commands
  end
end
