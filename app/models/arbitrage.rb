class Arbitrage < ActiveRecord::Base
  belongs_to :line1, :class_name => "PastLine", :foreign_key => :line1_id
  belongs_to :line2, :class_name => "PastLine", :foreign_key => :line2_id
  belongs_to :type, :class_name => "ArbitrageType", :foreign_key => :type_id
  
  def creation_time
    dif = 60 * 60 * 5
    self.created_at - dif
  end
  
  def convert_odds(odds)
		if odds < 0
			return (100/odds.abs) + 1
		else
			return 1 +(odds/100)
		end
	end

	def bet_size(bid_1, odds_1, odds_2)
		return (bid_1 * (odds_1/odds_2))
	end

	def arb?(odds_1, odds_2)
		return ((1/odds_1) + (1/odds_2) < 1)
	end

	def profit(bid_1, odds_1, odds_2)
		bid_2 = bet_size(bid_1, odds_1, odds_2)
		total_bid = (bid_1 + bid_2)
		return (bid_1 * odds_1 - (bid_1 + bet_size(bid_1, odds_1, odds_2)))
	end

	def percent_profit(bid_1, odds_1, odds_2)
		bid_2 = bet_size(bid_1, odds_1, odds_2)
		total_bid = (bid_1 + bid_2)
		profit = ((bid_1 * odds_1) - (bid_1 + bid_2))
		return ((profit/total_bid)*100)
	end

	def round_to(number, decimals)
		multiplier = 10**decimals
		((number * multiplier).round).to_f/multiplier
	end
	
	def switch
	  case self.type_id
    when 1 then
      if self.line1.money_line > self.line2.money_line
        temp = self.line1_id
        self.line1_id = self.line2_id
        self.line2_id = temp
        self.save
      end
    when 2 then
      if self.line1.spread_vig > self.line2.spread_vig
        temp = self.line1_id
        self.line1_id = self.line2_id
        self.line2_id = temp
        self.save
      end
    when 3 then
      if self.line1.total_points_vig > self.line2.total_points_vig
        temp = self.line1_id
        self.line1_id = self.line2_id
        self.line2_id = temp
        self.save
      end
    end
  end
	
	def profit_margin(amount)
	  case self.type_id
    when 1 then
      round_to(profit(amount.to_i, convert_odds(self.line1.money_line), convert_odds(self.line2.money_line)), 2)
    when 2 then
      round_to(profit(amount.to_i, convert_odds(self.line1.spread_vig), convert_odds(self.line2.spread_vig)), 2)
    when 3 then
      round_to(profit(amount.to_i, convert_odds(self.line1.total_points_vig), convert_odds(self.line2.total_points_vig)), 2)
    end
	end
	
	def second_bet_size(amount)
	  case self.type_id
    when 1 then
      round_to(bet_size(amount.to_i, convert_odds(self.line1.money_line), convert_odds(self.line2.money_line)), 2)
    when 2 then
      round_to(bet_size(amount.to_i, convert_odds(self.line1.spread_vig), convert_odds(self.line2.spread_vig)), 2)
    when 3 then
      round_to(bet_size(amount.to_i, convert_odds(self.line1.total_points_vig), convert_odds(self.line2.total_points_vig)), 2)
    end
  end

	def arb_percent
		if self.type.name == "Money Line"
			return round_to(percent_profit(100.to_f, convert_odds(self.line1.money_line), convert_odds(self.line2.money_line)), 4)
		elsif self.type.name == "Spread"
			return round_to(percent_profit(100.to_f, convert_odds(self.line1.spread_vig), convert_odds(self.line2.spread_vig)), 4)
		elsif self.type.name == "Total Points"
			return round_to(percent_profit(100.to_f, convert_odds(self.line1.total_points_vig), convert_odds(self.line2.total_points_vig)), 4)
		end
	end
	
	def arb_close
	  next_line1 = Line.find(:first, 
	                        :conditions => ["id > ? and betting_site_id = ? and team_id = ? and game_id = ?", self.line1.id, self.line1.betting_site_id, self.line1.team_id, self.line1.game_id], 
	                        :order => "created_at asc")
    next_line2 = Line.find(:first, 
    :conditions => ["id > ? and betting_site_id = ? and team_id = ? and game_id = ?", self.line2.id, self.line2.betting_site_id, self.line2.team_id, self.line2.game_id], 
                      	  :order => "created_at asc")
    if next_line1.nil? && next_line2.nil?
      return "Open"
    elsif next_line1.nil?
      return next_line2.created_at.to_s(:arb_time)
    elsif next_line2.nil?
      return next_line1.created_at.to_s(:arb_time)
    elsif next_line1.created_at < next_line2.created_at
      return next_line1.created_at.to_s(:arb_time)
    else
      return next_line2.created_at.to_s(:arb_time)
    end
  end
  
  def arb_open
    if self.line1.created_at > self.line2.created_at
      return line1.created_at.to_s(:arb_time)
    else
      return line2.created_at.to_s(:arb_time)
    end
  end
  
  def self.find_by_site(site_id, limit=20)
    arbs = Arbitrage.find(:all, 
                    :limit => limit, 
                    :joins => 'left join `lines` l on l.id = line1_id left join `lines` l_2 on l_2.id = line2_id', 
                    :conditions => ["l.betting_site_id = ?", site_id],
                    :order => 'created_at desc')
  end
  
  def self.open_arbs
    open_arbs = []
    arbs = Arbitrage.find(:all, :order => 'created_at DESC', :limit => 100)
    arbs.each do |arb|
      if arb.arb_close == 'Open'
        open_arbs << arb
      end
    end
    return open_arbs
  end
end
