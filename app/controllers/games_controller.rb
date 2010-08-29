class GamesController < ApplicationController
  # GET /games
  # GET /games.xml
  def index
    date = Time.zone.now
    @scores_date = date.yesterday
    if (params[:sport_id].nil?)
      @sport = ""
      @games = Game.random_games
      @scores = Game.scores(@games[0].sport_id) unless @games.length == 0
    else
      @sport = Sport.find(params[:sport_id]).name + " "
      @games = (session[:user_id].nil?) ? Game.games(params[:sport_id]) :Game.games(params[:sport_id], session[:user_id])
      @scores = Game.scores(params[:sport_id])
    end
      
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end

  def top_total_points
    @game = Game.find(params[:id])
    @sport = @game.sport.name
    @lines1 = (session[:user_id].nil?) ? Line.get_top_lines_per_browser(@game.team1_id, @game.id) : Line.get_top_lines_per_browser(@game.team1_id, @game.id, session[:user_id])
    @lines2 = (session[:user_id].nil?) ? Line.get_top_lines_per_browser(@game.team2_id, @game.id) : Line.get_top_lines_per_browser(@game.team2_id, @game.id, session[:user_id])
    @scores = Game.scores(@game.sport.id)

    respond_to do |format|
      format.html # top_lines.html.erb
      #format.xml  { render :xml => @game }
    end    
  end
  
  def top_moneylines
    @game = Game.find(params[:id])
    @sport = @game.sport.name
    @lines1 = (session[:user_id].nil?) ? Line.get_top_lines_per_browser(@game.team1_id, @game.id) : Line.get_top_lines_per_browser(@game.team1_id, @game.id, session[:user_id])
    @lines2 = (session[:user_id].nil?) ? Line.get_top_lines_per_browser(@game.team2_id, @game.id) : Line.get_top_lines_per_browser(@game.team2_id, @game.id, session[:user_id])
    @scores = Game.scores(@game.sport.id)

    respond_to do |format|
      format.html # top_lines.html.erb
      #format.xml  { render :xml => @game }
    end    
  end

  def top_spreads
    @game = Game.find(params[:id])
    @sport = @game.sport.name
    @lines1 = (session[:user_id].nil?) ? Line.get_top_lines_per_browser(@game.team1_id, @game.id) : Line.get_top_lines_per_browser(@game.team1_id, @game.id, session[:user_id])
    @lines2 = (session[:user_id].nil?) ? Line.get_top_lines_per_browser(@game.team2_id, @game.id) : Line.get_top_lines_per_browser(@game.team2_id, @game.id, session[:user_id])
    @scores = Game.scores(@game.sport.id)

    respond_to do |format|
      format.html # top_lines.html.erb
      #format.xml  { render :xml => @game }
    end    
  end


  # GET /games/1
  # GET /games/1.xml
  def show
    @game = Game.find(params[:id])
    @sport = @game.sport.name
    date = Time.zone.now
    @scores = Game.scores(@game.sport.id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end
end
