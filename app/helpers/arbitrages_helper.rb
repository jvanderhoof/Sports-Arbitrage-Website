module ArbitragesHelper
  def display_arb(arb, bid_amount)
    html = '<table class="display">'
    html += "<tr><th>Type</th><th>Bid Amount</th><th>Odds</th><th>Website</th><th>Team</th></tr>"
    html += '<tr class="row1">'
    html += "<td>#{arb.type.name}</td>"
    case arb.type_id
    when 1 then
      html += "<td>$#{bid_amount}</td>"
      html += "<td>#{arb.line1.money_line}</td>"
      html += "<td>#{arb_site(arb.line1.betting_site)}</td>"
      html += "<td>#{arb.line1.team.name}</td>"
      html += '</tr><tr class="row2">'
      html += "<td></td>"
      html += "<td>$#{arb.second_bet_size(bid_amount)}</td>"
      html += "<td>#{arb.line2.money_line}</td>"
      html += "<td>#{arb_site(arb.line2.betting_site)}</td>"
      html += "<td>#{arb.line2.team.name}</td>"
    when 2 then
      html += "<td>$#{bid_amount}</td>"
      html += "<td>#{arb.line1.spread_vig}</td>"
      html += "<td>#{arb_site(arb.line1.betting_site)}</td>"
      html += "<td>#{arb.line1.team.name}</td>"
      html += '</tr><tr class="row2">'
      html += "<td></td>"
      html += "<td>$#{arb.second_bet_size(bid_amount)}</td>"
      html += "<td>#{arb.line2.spread_vig}</td>"
      html += "<td>#{arb_site(arb.line2.betting_site)}</td>"
      html += "<td>#{arb.line2.team.name}</td>"
    when 3 then
      html += "<td>$#{bid_amount}</td>"
      html += "<td>#{arb.line1.total_points_vig}</td>"
      html += "<td>#{arb_site(arb.line1.betting_site)}</td>"
      html += "<td>#{arb.line1.team.name}</td>"
      html += '</tr><tr class="row2">'
      html += "<td></td>"
      html += "<td>$#{arb.second_bet_size(bid_amount)}</td>"
      html += "<td>#{arb.line2.total_points_vig}</td>"
      html += "<td>#{arb_site(arb.line2.betting_site)}</td>"
      html += "<td>#{arb.line2.team.name}</td>"
    end
    html += "</tr>"
    html += "</table>"
    return html
  end
  
  def arb_site(betting_site)
    return "<a href='#{betting_site.website_link}' target='_blank'>#{betting_site.name}</a>"
  end
  
  def arb_row(arb_line, type)
    html = '<td>'
    if type == 1
      html += "#{arb_line.money_line}"
    end
    if type == 2
      html += "#{arb_line.spread_vig}"
      html += " (#{arb_line.spread})"
    end
    if type == 3
      html += "#{arb_line.total_points_vig}"
      html += " (#{arb_line.total_points})"
    end
    html += '</td>'
    return html
  end
  
  def arb_type_link(arb)
    case arb.type_id
    when 1 then
      type = 'top_moneylines'
    when 2 then
      type = 'top_spreads'
    when 3 then
      type = 'top_total_points'
    end
    return "<a href='/games/#{type}/#{arb.line1.game_id}'>#{arb.type.name}</a>"
  end
end
