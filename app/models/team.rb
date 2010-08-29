class Team < ActiveRecord::Base
  has_many :lines
  has_many :past_lines
  has_many :team_synonyms
  has_one :top_line
  belongs_to :sport
  has_many :user_teams
  has_many :users, :through => :user_teams  
  
  
  validates_presence_of :sport, :name, :message => "Missing required field"
  
  def top_lines(game_id, user_id=0)
    lines = (user_id == 0) ? Line.get_top_lines_per_browser(self.id, game_id) : Line.get_top_lines_per_browser(self.id, game_id, user_id)
    top = {}
    best_value = -100000000
    line_id = ''
    lines.each {|line|
      unless line.money_line.nil? || line.money_line == 0
        if (line.money_line > best_value)          
          line_id = line.id
          best_value = line.money_line
        end
      end
    }
    line_arr = Array.new
    lines.each {|line|
      unless line.money_line.nil? || line.money_line == 0
        if (line.money_line == best_value)          
          line_arr << line.id
        end
      end
    }
    
    top['money_line'] = Line.find(line_arr[rand(line_arr.length)]) unless line_id == ''

    best_value = -100000000
    line_id = ''
    lines.each {|line|
      unless line.spread_vig.nil? || line.spread_vig == 0
        if (line.spread_vig > best_value)
          line_id = line.id
          best_value = line.spread_vig
        end
      end
    }
    line_arr = Array.new
    lines.each {|line|
      unless line.spread_vig.nil? || line.spread_vig == 0
        if (line.spread_vig == best_value)          
          line_arr << line.id
        end
      end
    }

    top['spread'] = Line.find(line_arr[rand(line_arr.length)]) unless line_id == ''
    
    best_value = -100000000
    line_id = ''
    lines.each {|line|
      unless line.total_points_vig.nil? || line.total_points_vig == 0
        if (line.total_points_vig > best_value)
          line_id = line.id
          best_value = line.total_points_vig
        end
      end
    }
    line_arr = Array.new
    lines.each {|line|
      unless line.total_points_vig.nil? || line.total_points_vig == 0
        if (line.total_points_vig == best_value)          
          line_arr << line.id
        end
      end
    }
    
    top['total_points'] = Line.find(line_arr[rand(line_arr.length)]) unless line_id == ''
    return top
  end
  
  def top_money_line_line(game_id)
    lines = Line.get_top_lines_per_browser(id, game_id)
    best_value = -100000000
    id = ''
    lines.each {|line|
      unless line.money_line.nil? || line.money_line == 0
        if (line.money_line > best_value)
          id = line.id
          best_value = line.money_line
        end
      end
    }
    return Line.find(id) unless id == ""
  end
  
  def top_spread_line(game_id)
    lines = Line.get_top_lines_per_browser(id, game_id)
    best_value = -100000000
    id = ''
    lines.each {  |line|
      unless line.spread_line.nil? || line.spread_line.spread_vig.nil?
        if (line.spread_line.spread_vig > best_value)
          id = line.spread_line.id
          best_value = line.spread_line.spread_vig
        end
      end
    }
    return Line.find(id) unless id == ""    
  end
  
  def top_total_points_line(game_id)
    lines = Line.get_top_lines_per_browser(id, game_id)
    best_value = -100000000
    id = ''
    lines.each {  |line|
      unless line.total_points_line.nil? || line.total_points_line.total_points_vig.nil?
        if (line.total_points_line.total_points_vig > best_value)
          id = line.total_points_line_id
          best_value = line.total_points_line.total_points_vig
        end
      end
    }
    return Line.find(id) unless id == ""    
  end
end
