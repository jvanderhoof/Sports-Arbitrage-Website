class AddArbClosed < ActiveRecord::Migration
  def self.up
    add_column :arbitrages, :open, :boolean, :default => true
    add_column :lines, :past_line_id, :integer
  end

  def self.down
    remove_column :arbitrages, :open
    remove_column :lines, :past_line_id
  end
end
