require 'rubygems'
require 'hpricot'
require 'open-uri'

class Utilities
  def self.sync_game_scores
    day = DateTime.now
    j = -1
    message = ""
    while j > -2
      day = day.advance(:days => j)
      message += "----------------- NBA -----------------------<br/>"
      url = "http://sports.yahoo.com/nba/scoreboard?d=#{day}&refresh=0"
      Utilities.get_game_scores(url, day, 2)

      message += "----------------- NHL -----------------------<br/>"
      url = "http://sports.yahoo.com/nhl/scoreboard?d=#{day}&refresh=0"
      Utilities.get_game_scores(url, day, 5)

      message += "----------------- NCAA Basketball -----------------------<br/>"
      url = "http://rivals.yahoo.com/ncaa/basketball/scoreboard?d=#{day}&c=all&refresh=0"
      Utilities.get_game_scores(url, day, 3)

      message += "----------------- MLB -----------------------<br/>"
      url = "http://sports.yahoo.com/mlb/scoreboard?d=#{day}&c=all&refresh=0"
      Utilities.get_game_scores(url, day, 6)

    	day = day.next
    	j -= 1
    	sleep(2)
    end
    return message
  end
  
  def self.set_game_score(team1_id, team2_id, date, team1_score, team2_score)
    game = Game.find(:first, 
              :conditions => ["team1_id = ? and team2_id = ? and game_time > ? and game_time < ?", team1_id, team2_id, date.strftime("%Y-%m-%d"), date.advance(:days => 2).strftime("%Y-%m-%d")])
    if game.nil?
      game = Game.find(:first, 
                :conditions => ["team1_id = ? and team2_id = ? and game_time > ? and game_time < ?", team2_id, team1_id, date.strftime("%Y-%m-%d"), date.advance(:days => 2).strftime("%Y-%m-%d")])
      unless game.nil?
        game.team1_score = team2_score
        game.team2_score = team1_score
        game.save
      end
    else
      game.team1_score = team1_score
      game.team2_score = team2_score
      game.save
    end
  end
  
	def self.get_game_scores(url, date, sport)
    doc = open(url) { |f| Hpricot(f) }
    
  	rows = (doc/"tr.ysptblclbg5")
  	i = 0
  	while i < rows.length
  	  cols = (rows[i]/"td")
  		team = (rows[i]/"td.yspscores > b > a")
  		team1_id = Utilities.get_team(team.inner_html, sport)
  		if cols.length > 10
  	    team1_score = cols[cols.length - 3].inner_text.strip
		  else
  	    team1_score = cols[cols.length - 2].inner_text.strip
	    end
      
      i += 1
  	  cols = (rows[i]/"td")
  		team = (rows[i]/"td.yspscores > b > a")
  		team2_id = Utilities.get_team(team.inner_html, sport)
  		if cols.length > 10
  	    team2_score = cols[cols.length - 3].inner_text.strip
		  else
  	    team2_score = cols[cols.length - 2].inner_text.strip
	    end
      
      Utilities.set_game_score(team1_id, team2_id, date, team1_score, team2_score)
  	  i += 1
		end
  end
  
  def self.get_team(team_name, sport)
    team_name = Utilities.strip_characters(team_name)
    
    team = Team.find(:first, :conditions => ["name = ? and sport_id = ?", team_name, sport])
    if team.nil? || team.name.nil?
      synonym = TeamSynonym.find(:first, :conditions => ["synonym =? and sport_id = ?", team_name, sport])      
      team = Team.find(:first, :conditions => ["id = ? and sport_id = ?", synonym.team_id, sport]) unless synonym.nil?      
    end
    if (team.nil? || team.name.nil?)      
      team = UnknownTeam.find(:first, :conditions => ["name = ? and sport_id = ?", team_name, sport])
      if team.nil?
        return ""
      else
        return team.id
      end
    else
      return team.id
    end
  end

  def self.strip_characters(team)
    team = team.strip
    team = team.gsub("\302\240", "")
    team = team.gsub("'", "")
    team = team.gsub(".", "")
    team = team.gsub("(", "")
    team = team.gsub(")", "")
    team = team.gsub("-", " ")
    team = team.gsub("\r\n", "")
    team = team.gsub("\342\200\231", "")
    team = team.gsub("&amp;", "&")
    return team
  end
end
