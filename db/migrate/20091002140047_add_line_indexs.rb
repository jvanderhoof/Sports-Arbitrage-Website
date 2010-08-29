class AddLineIndexs < ActiveRecord::Migration
  def self.up
    add_index(:lines, [:game_id, :team_id, :betting_site_id], :unique => false, :name => 'game_team_site_idx' )
  end

  def self.down
  end
end
