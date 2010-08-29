class Game < ActiveRecord::Base
  has_many :lines
  has_many :past_lines
  has_many :referals
  has_one :top_line  
  belongs_to :team1, :class_name => "Team", :foreign_key => :team1_id
  belongs_to :team2, :class_name => "Team", :foreign_key => :team2_id
  belongs_to :draw, :class_name => "Team", :foreign_key => :draw_id
  belongs_to :sport
  
  def self.games(sport_id, user_id=0)
    date = Time.zone.now.advance(:hours => 3)
    #009-05-07 00:10:00
    #return Game.find(:all, :conditions => ["game_time >= ? and sport_id = ?", date.strftime("%Y-%m-%d %H:%M:%S"), sport_id], :order => :game_time)
    if user_id == 0
      Game.find(:all, :conditions => ["game_time >= ? and sport_id = ?", date.strftime("%Y-%m-%d %H:%M:%S"), sport_id], :order => :game_time)
    else
      user = User.find(user_id)
      Game.find(:all, :conditions => ["game_time >= ? and (team1_id in (?) or team2_id in (?)) and sport_id = ?",date.strftime("%Y-%m-%d %H:%M:%S"),user.teams, user.teams, sport_id], :order => :game_time)
    end
  end
  
  def self.scores(sport_id)
    date = Time.zone.now
    return Game.find(:all, 
          :conditions => ["game_time > ? and game_time < ? and sport_id = ?", date.yesterday.strftime("%Y-%m-%d"), date.tomorrow.strftime("%Y-%m-%d"), sport_id], 
          :order => :game_time)
  end
  
  def self.random_scores
    Game.scores(Game.random_sport)
  end
  
  def self.random_games
    Game.games(Game.random_sport)
  end
    
  def self.random_sport
    id = ''
    count = 0
    sports = Sport.find(:all)
    while id.to_s.length == 0 && count < 8
      sport = sports[rand(sports.length)]
      games = self.games(sport.id)
      if games.length > 0 && games[0].lines.length > 0
        id = sport.id
      else
        count += 1
      end
    end
    return id
  end

end
