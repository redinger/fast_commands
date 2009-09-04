class FastCommandsCreateAvailableCommands < ActiveRecord::Migration
  def self.up
    create_table :available_commands do |t|
      t.string :name
      t.string :value, :limit => 100
      t.string :device_type
      t.timestamps
    end
    
    add_index :available_commands, :device_type
  end

  def self.down
    remove_index :available_commands, :device_type
    drop_table :available_commands
  end
end