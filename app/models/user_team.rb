class UserTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  
  def all_teams?(sport_id)
    user_count = UserTeam.count_by_sql(["select count(*) from user_teams ut left join teams t on ut.team_id = t.id where t.sport_id = ? and ut.user_id = ?", sport_id, self.user_id])
    team_count = UserTeam.count_by_sql(["select count(*) from teams where sport_id = ? and name <> 'Draw'", sport_id])
    user_count.to_i == team_count.to_i
  end
end
