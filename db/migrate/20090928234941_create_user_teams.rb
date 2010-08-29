class CreateUserTeams < ActiveRecord::Migration
  def self.up
    create_table :user_teams do |t|
      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end

    add_index :user_teams, :user_id
    add_index :user_teams, :team_id    

  end

  def self.down
    drop_table :user_teams
  end
end
