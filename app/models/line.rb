class Line < ActiveRecord::Base
  belongs_to :team
  belongs_to :game
  belongs_to :betting_site
  belongs_to :arbitrage
    
  def self.get_top_lines_per_browser(team_id, game_id, user_id=0)
    where = (user_id == 0) ? '' : " and betting_site_id in (#{User.find(user_id).betting_sites.map{|i|i.id}.join(',')})"
    #lines = Line.find_by_sql(["select `lines`.* from `lines` inner join (select max(id) as id from `lines` where game_id = ? and team_id = ? #{where} group by betting_site_id) ids on `lines`.id = ids.id", game_id, team_id])
    Line.all(:conditions => ["team_id = ? and game_id = ? #{where}", team_id, game_id])
  end
end
