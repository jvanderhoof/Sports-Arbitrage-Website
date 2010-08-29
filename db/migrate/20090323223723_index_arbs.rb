class IndexArbs < ActiveRecord::Migration
  def self.up
    add_index :arbitrages, :line1_id
    add_index :arbitrages, :line2_id
    add_index :arbitrages, :type_id
  end

  def self.down
    remove_index :arbitrages, :line1_id
    remove_index :arbitrages, :line2_id
    remove_index :arbitrages, :type_id
  end
end
