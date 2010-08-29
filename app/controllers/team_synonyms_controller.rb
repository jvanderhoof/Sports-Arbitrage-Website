class TeamSynonymsController < ApplicationController
  before_filter :login_required
  layout'admin' 

  # GET /team_synonyms
  # GET /team_synonyms.xml
  def index
    @team_synonyms = TeamSynonym.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @team_synonyms }
    end
  end

  # GET /team_synonyms/1
  # GET /team_synonyms/1.xml
  def show
    @team_synonym = TeamSynonym.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team_synonym }
    end
  end

  # GET /team_synonyms/new
  # GET /team_synonyms/new.xml
  def new
    @team_synonym = TeamSynonym.new
    team = Team.find(params[:id])
    @team_synonym.team_id = team.id
    @team_synonym.sport_id = team.sport_id
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team_synonym }
    end
  end

  # GET /team_synonyms/1/edit
  def edit
    @team_synonym = TeamSynonym.find(params[:id])
  end

  # POST /team_synonyms
  # POST /team_synonyms.xml
  def create
    @team_synonym = TeamSynonym.new(params[:team_synonym])

    respond_to do |format|
      if @team_synonym.save
        flash[:notice] = 'TeamSynonym was successfully created.'
        format.html { redirect_to(:controller => 'teams', :sport_id => @team_synonym.sport_id) }
        format.xml  { render :xml => @team_synonym, :status => :created, :location => @team_synonym }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team_synonym.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /team_synonyms/1
  # PUT /team_synonyms/1.xml
  def update
    @team_synonym = TeamSynonym.find(params[:id])

    respond_to do |format|
      if @team_synonym.update_attributes(params[:team_synonym])
        flash[:notice] = 'TeamSynonym was successfully updated.'
        format.html { redirect_to(@team_synonym) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team_synonym.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /team_synonyms/1
  # DELETE /team_synonyms/1.xml
  def destroy
    @team_synonym = TeamSynonym.find(params[:id])
    @team_synonym.destroy

    respond_to do |format|
      format.html { redirect_to(team_synonyms_url) }
      format.xml  { head :ok }
    end
  end
end
