class ContentsController < ApplicationController
  def refer
    line_id = params[:line_id]
    unless line_id.nil?
      referal = Referal.new
      line = Line.find(line_id)
      referal.betting_site_id = line.betting_site_id
      referal.game_id = line.game_id
      referal.save
      site = BettingSite.find(line.betting_site_id)
      unless site.nil?
        redirect_to(site.website_link + site.affiliate_code)
      else
        redirect_to("/")
      end
    end
  end
  
  def faq
    @scores = Game.random_scores
  end
  
  def about
    @scores = Game.random_scores
  end
  
  def thanks
    @scores = Game.random_scores
  end
  
  def sync_game_scores
    @message = Utilities.sync_game_scores
  end
end