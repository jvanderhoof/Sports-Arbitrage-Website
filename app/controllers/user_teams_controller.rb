class UserTeamsController < ApplicationController
  before_filter :login_required

  # GET /user_teams
  # GET /user_teams.xml
  def index
    @user_teams = UserTeam.find(:all, :conditions => ["user_id = ?", session[:user_id]])
    @sports = Sport.find(:all, :order => :name)
    @user_team = UserTeam.new
    @user_team.user_id = session[:user_id]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_teams }
    end
  end

  # GET /user_teams/1
  # GET /user_teams/1.xml
  def show
    @user_team = UserTeam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_team }
    end
  end

  # GET /user_teams/new
  # GET /user_teams/new.xml
  def new
    @user_team = UserTeam.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_team }
    end
  end

  # GET /user_teams/1/edit
  def edit
    @user_team = UserTeam.find(params[:id])
  end

  # POST /user_teams
  # POST /user_teams.xml
  def create
    user = User.find(session[:user_id])
    user.user_teams.each {|team| team.delete}
    params[:items].keys.each {|team| UserTeam.create({:user_id => user.id, :team_id => team.to_i})} unless params[:items].nil?
    flash[:notice] = 'Your Team selections were successfully updated.'
    redirect_to :controller => 'users', :action => 'index'


=begin
    @user_team = UserTeam.new(params[:user_team])

    respond_to do |format|
      if @user_team.save
        flash[:notice] = 'UserTeam was successfully created.'
        format.html { redirect_to(@user_team) }
        format.xml  { render :xml => @user_team, :status => :created, :location => @user_team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_team.errors, :status => :unprocessable_entity }
      end
    end
=end
  end

  # PUT /user_teams/1
  # PUT /user_teams/1.xml
  def update
    @user_team = UserTeam.find(params[:id])

    respond_to do |format|
      if @user_team.update_attributes(params[:user_team])
        flash[:notice] = 'UserTeam was successfully updated.'
        format.html { redirect_to(@user_team) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_teams/1
  # DELETE /user_teams/1.xml
  def destroy
    @user_team = UserTeam.find(params[:id])
    @user_team.destroy

    respond_to do |format|
      format.html { redirect_to(user_teams_url) }
      format.xml  { head :ok }
    end
  end
end
