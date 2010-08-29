class UnknownTeamsController < ApplicationController
  before_filter :login_required
  layout'admin' 

  # GET /unknown_teams
  # GET /unknown_teams.xml
  def index
    @unknown_teams = UnknownTeam.find(:all, :conditions => 'hide = 0')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @unknown_teams }
    end
  end

  # GET /unknown_teams/1
  # GET /unknown_teams/1.xml
  def show
    @unknown_team = UnknownTeam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @unknown_team }
    end
  end

  # GET /unknown_teams/new
  # GET /unknown_teams/new.xml
  def new
    @unknown_team = UnknownTeam.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @unknown_team }
    end
  end

  # GET /unknown_teams/1/edit
  def edit
    @unknown_team = UnknownTeam.find(params[:id])
  end

  # POST /unknown_teams
  # POST /unknown_teams.xml
  def create
    @unknown_team = UnknownTeam.new(params[:unknown_team])

    respond_to do |format|
      if @unknown_team.save
        flash[:notice] = 'UnknownTeam was successfully created.'
        format.html { redirect_to(@unknown_team) }
        format.xml  { render :xml => @unknown_team, :status => :created, :location => @unknown_team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @unknown_team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /unknown_teams/1
  # PUT /unknown_teams/1.xml
  def update
    @unknown_team = UnknownTeam.find(params[:id])
    if params[:commit] == "Update"
      team = Team.find(params[:team][:team_id])
      unless team.nil?
        synonym = TeamSynonym.new
        synonym.synonym = @unknown_team.name
        synonym.team_id = team.id
        synonym.sport_id = team.sport_id
        if synonym.save
          @unknown_team.destroy
          respond_to do |format|
            format.html { redirect_to(unknown_teams_url) }          
          end
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @unknown_team.errors, :status => :unprocessable_entity }
        end
      end
    elsif (params[:commit] == "Create New Team")
      team = Team.new
      team.sport_id = @unknown_team.sport_id
      team.name = @unknown_team.name
      if team.save
        @unknown_team.destroy
        respond_to do |format|
          format.html { redirect_to(unknown_teams_url) }          
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @unknown_team.errors, :status => :unprocessable_entity }
      end
    else
      format.html { render :action => "edit" }
      format.xml  { render :xml => @unknown_team.errors, :status => :unprocessable_entity }
    end
  end
  
  def hide
    unknown_team = UnknownTeam.find(params[:id])
    unknown_team.hide = 1
    unknown_team.save
    respond_to do |format|
      format.html { redirect_to(unknown_teams_url) }          
    end
    
  end

  # DELETE /unknown_teams/1
  # DELETE /unknown_teams/1.xml
  def destroy
    @unknown_team = UnknownTeam.find(params[:id])
    @unknown_team.destroy

    respond_to do |format|
      format.html { redirect_to(unknown_teams_url) }
      format.xml  { head :ok }
    end
  end
end
