class BettingSite < ActiveRecord::Base
  has_many :lines
  has_many :past_lines
  has_many :pages
  has_many :user_betting_sites
  has_many :users, :through => :user_betting_sites
  
  def lines
    pages.find(:all, :conditions => ["betting_site_id = ?", self.id], :limit => 100, :order => "created_at DESC")
  end
end
