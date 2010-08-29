class PastLine < ActiveRecord::Base
  belongs_to :team
  belongs_to :game
  belongs_to :betting_site
  has_many :arbitrage
    
  def self.get_top_lines_per_browser(team_id, game_id, user_id=0)
    where = (user_id == 0) ? '' : " and betting_site_id in (#{User.find(user_id).betting_sites.map{|i|i.id}.join(',')})"
    lines = Line.find_by_sql(["select `lines`.* from `lines` inner join (select max(id) as id from `lines` where game_id = ? and team_id = ? #{where} group by betting_site_id) ids on `lines`.id = ids.id", game_id, team_id])
    #raise lines.to_yaml
  end
end
