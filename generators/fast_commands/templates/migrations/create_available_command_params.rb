class FastCommandsCreateAvailableCommandParams < ActiveRecord::Migration
  def self.up
    create_table :available_command_params do |t|
      t.references :available_command
      t.string :name
      t.string :label
      t.timestamps
    end
    
    add_index :available_command_params, :available_command_id
  end

  def self.down
    remove_index :available_command_params, :available_command_id
    drop_table :available_command_params
  end
end