# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def display_checkboxes(checked_items, items, id_method, indent=0, parent_id='')
    ids = []
    checked_items.each {|item| ids << item.instance_eval(id_method)}
    html = []
    html_indent = (indent == 0) ? '' : '&nbsp;&nbsp;' * indent
    items.each do |item|
      checked = (ids.include?(item.id)) ? 'CHECKED' : ''
      html << "#{html_indent}<input type='checkbox' class='#{parent_id}' name=items[#{item.id}] #{checked}>&nbsp;&nbsp;#{item.name}<br />" unless item.name == 'Draw'
    end
    return html.join('')
  end
  
  def display_sports_checkboxes(checked_items, items, user_team)
    ids = []
    checked_items.each {|item| ids << item.team_id}
    html = []
    items.each do |item|
      checked = (user_team.all_teams?(item.id)) ? 'CHECKED' : ''
      html << "<input #{checked} type='checkbox'  class='sports' id='team_#{item.id}'>&nbsp;&nbsp;#{item.name}<br />"
      html << display_checkboxes(checked_items, item.teams, "team_id", 2, "team_#{item.id}")
    end
    return html.join('')
  end
  
  def login_or_logout(user_id)
    (user_id.nil?) ? '<a href="/login">login</a>' : '<a href="/logout">logout</a>'
  end
  
  def left_menu
    sports = Sport.active_sports
    html = []
    html << '<div>sports menu</div>'
		html << '<ul>'
		if sports.include?('NFL') or sports.include?('NCAA Football')
      html << '<li>Football'
  		html << '<ul>'
  		html << '<li><a title="Current Top NFL Lines" href="/games?sport_id=1">NFL</a></li>' if sports.include?('NFL')
  		html << '<li><a href="/games?sport_id=4">NCAA</a></li>' if sports.include?('NCAA Football')
  		html << '</ul>'
  		html << '</li>'
  	end
		if sports.include?('NBA') or sports.include?('NCAA Basketball')
      html << '<li>Basketball'
  		html << '<ul>'
  		html << '<li><a title="Current Top NBA Lines" href="/games?sport_id=2">NBA</a></li>' if sports.include?('NBA')
  		html << '<li><a href="/games?sport_id=3">NCAA</a></li>' if sports.include?('NCAA Basketball')
  		html << '</ul>'
  		html << '</li>'
  	end
  	if sports.include?('MLB')
			html << '<li>Baseball'
			html << '<ul>'
			html << '<li><a title="Current Top MLB Lines" href="/games?sport_id=6">MLB</a></li>'
			html << '</ul>'
			html << '</li>'
		end
		if sports.include?('NHL')
			html << '<li>Ice Hockey'
			html << '<ul>'
			html << '<li><a title="Current Top NHL Lines" href="/games?sport_id=5">NHL</a></li>'
			html << '</ul>'
			html << '</li>'
		end
		if sports.include?('English Premier') or sports.include?('UEFA')
			html << '<li>Soccer'
			html << '<ul>'
			html << '<li><a title="Current Top English Premier Soccer Lines" href="/games?sport_id=7">English Premier</a></li>' if sports.include?('English Premier')
			html << '<li><a title="Current Top UEFA Soccer Lines" href="/games?sport_id=8">UEFA</a></li>' if sports.include?('UEFA')
			html << '</ul>'
			html << '</li>'
		end
		html << '</ul>'
		html << '<div class="sp_curve"></div>'
    html.join('')
  end
end
