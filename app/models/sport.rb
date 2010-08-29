class Sport < ActiveRecord::Base
  has_many :teams, :order => :name
  has_many :games
  has_many :pages
  has_many :unknown_teams
  has_many :referals
  
  def self.active_sports
    Sport.find(:all, :conditions => 'active = 1').map{|i| i.name}
  end
end
