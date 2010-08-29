class CreateUserBettingSites < ActiveRecord::Migration
  def self.up
    create_table :user_betting_sites do |t|
      t.integer :user_id
      t.integer :betting_site_id

      t.timestamps
    end
    
    add_index :user_betting_sites, :user_id
    add_index :user_betting_sites, :betting_site_id    
  end

  def self.down
    drop_table :user_betting_sites
  end
end
