module GamesHelper
  
  def display_game_odds(top_lines, game_id, team_name)
    return_str = ''
    count = 1
    if (!top_lines['money_line'].nil? && top_lines['money_line'].money_line.to_f != 0)
      return_str += new_odds_row(top_lines, 'Money Line', 'top_moneylines', game_id, 'money_line', 'background-color:#ccc;')
      count += 1
    end
    if (!top_lines['spread'].nil? && top_lines['spread'].spread.to_f != 0)
      style = (count % 2 == 1) ? 'background-color:#ccc;' : ''
      return_str += new_odds_row(top_lines, 'Spread', 'top_spreads', game_id, 'spread', style)
      count += 1
    end
    if (!top_lines['total_points'].nil? && top_lines['total_points'].total_points.to_f != 0)
      style = (count % 2 == 1) ? 'background-color:#ccc;' : ''
      return_str += new_odds_row(top_lines, 'Total Points', 'top_total_points', game_id, 'total_points', style)
      count += 1
    end
    return_str = '<tr><th rowspan="'+count.to_s+'" valign="top" class="teams" style="width:27%">' + team_name + '</th></tr>' + return_str
  end

  def new_odds_row(top_lines, link_title, link_action, link_id, type, style)
    return_str = '<tr style="'+style+'">'
    return_str += '<td style="'+style+'" class="games_links">' + link_to(link_title, {:action => link_action, :id => link_id}, 
                                                                      {:title => "View all #{link_title} Odds"}) + '</td>'
		return_str += '<td>' + format_odds_hash(top_lines, type) + '</td>'
		return_str += '<td>' + format_site_hash(top_lines, type) + '</td>'
		return_str += '</tr>'
		return return_str
  end	
  
  def format_odds_hash(odds_hash, odds_type)
    format_odds(odds_hash[odds_type], odds_type)
  end
  
  def format_site_hash(odds_hash, odds_type)
    format_site(odds_hash[odds_type], odds_type)
  end
  
  def format_odds(obj, odds_type)
    odds = ""
    if obj.nil?
      return odds
    else
      case odds_type
      when 'money_line'
        odds = obj.money_line
      when 'spread'
        odds = obj.spread_vig
      when 'total_points'
        odds = obj.total_points_vig
      end
      odds = format_number(odds)
      if !odds.to_s.include?("-") && odds.to_s.length > 1
        odds = "+#{odds}"
      end
      if odds.to_s.length < 1 || odds.to_f == 0
        odds = "N/A"
      end
    end
    return odds
  end
  
  def format_site(obj, odds_type)
    site = ""
    if obj.nil?
      return site
    else
      site = '<a href="/refer?line_id='+obj.id.to_s+'" title="Place a bet with '+obj.betting_site.name+'" target="_new">' + obj.betting_site.name + '</a>' + " (" + obj.updated_at.to_s(:game_line) + ")"
    end
    return site
  end
  
  def format_number(number)
    if number.to_s.include?(".0")
      number = number.to_s.gsub(".0", "")
    end
    return number
  end
end
