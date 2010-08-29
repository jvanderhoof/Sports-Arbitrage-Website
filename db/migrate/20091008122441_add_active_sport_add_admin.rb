class AddActiveSportAddAdmin < ActiveRecord::Migration
  def self.up
    #add_column :sports, :active, :boolean, :default => true
  end

  def self.down
    remove_column :sports, :active
  end
end
