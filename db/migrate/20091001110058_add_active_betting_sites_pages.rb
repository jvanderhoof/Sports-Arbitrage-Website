class AddActiveBettingSitesPages < ActiveRecord::Migration
  def self.up
    add_column :betting_sites, :active, :boolean, :default => 0
    add_column :pages, :active, :boolean, :default => 0
  end

  def self.down
    remove_column :betting_sites, :active
    remove_column :pages, :active
  end
end
