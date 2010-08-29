class AddUnknownTeamHide < ActiveRecord::Migration
  def self.up
    add_column :unknown_teams, :hide, :boolean, :default => 0
  end

  def self.down
    remove_column :unknown_teams, :hide
  end
end
