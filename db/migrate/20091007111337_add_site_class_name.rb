class AddSiteClassName < ActiveRecord::Migration
  def self.up
    add_column :betting_sites, :class_name, :string
    add_column :betting_sites, :xml_feed, :boolean
    add_column :betting_sites, :sleep_time, :integer
  end

  def self.down
    remove_column :betting_sites, :class_name
    remove_column :betting_sites, :xml_feed
    remove_column :betting_sites, :sleep_time
  end
end
