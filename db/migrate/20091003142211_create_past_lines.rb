class CreatePastLines < ActiveRecord::Migration
  def self.up
    create_table :past_lines do |t|
      t.integer :team_id
      t.integer :game_id
      t.integer :betting_site_id
      t.float :spread
      t.float :spread_vig
      t.float :money_line
      t.string :over_under
      t.float :total_points
      t.float :total_points_vig

      t.timestamps
    end
    add_index(:past_lines, :team_id)
    add_index(:past_lines, :game_id)
    add_index(:past_lines, :betting_site_id)
  end

  def self.down
    drop_table :past_lines
    remove_index(:past_lines, :team_id)
    remove_index(:past_lines, :game_id)
    remove_index(:past_lines, :betting_site_id)    
  end
end
