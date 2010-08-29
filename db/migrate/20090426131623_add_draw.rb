class AddDraw < ActiveRecord::Migration
  def self.up
    add_column :games, :draw_id, :integer, :default => 0
  end

  def self.down
    remove_column :games, :draw_id
  end
end
