class BettingSitesController < ApplicationController
  before_filter :login_required
  layout'admin' 

  # GET /betting_sites
  # GET /betting_sites.xml
  def index
    @betting_sites = BettingSite.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @betting_sites }
    end
  end

  # GET /betting_sites/1
  # GET /betting_sites/1.xml
  def show
    @betting_site = BettingSite.find(params[:id])
    @lines = Line.find(:all, :conditions => ["betting_site_id = ?", @betting_site.id], :order => "created_at DESC", :limit => 100 )

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @betting_site }
    end
  end

  # GET /betting_sites/new
  # GET /betting_sites/new.xml
  def new
    @betting_site = BettingSite.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @betting_site }
    end
  end

  # GET /betting_sites/1/edit
  def edit
    @betting_site = BettingSite.find(params[:id])
  end

  # POST /betting_sites
  # POST /betting_sites.xml
  def create
    @betting_site = BettingSite.new(params[:betting_site])

    respond_to do |format|
      if @betting_site.save
        flash[:notice] = 'BettingSite was successfully created.'
        format.html { redirect_to(@betting_site) }
        format.xml  { render :xml => @betting_site, :status => :created, :location => @betting_site }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @betting_site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /betting_sites/1
  # PUT /betting_sites/1.xml
  def update
    @betting_site = BettingSite.find(params[:id])

    respond_to do |format|
      if @betting_site.update_attributes(params[:betting_site])
        flash[:notice] = 'BettingSite was successfully updated.'
        format.html { redirect_to(@betting_site) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @betting_site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /betting_sites/1
  # DELETE /betting_sites/1.xml
  def destroy
    @betting_site = BettingSite.find(params[:id])
    @betting_site.destroy

    respond_to do |format|
      format.html { redirect_to(betting_sites_url) }
      format.xml  { head :ok }
    end
  end
end
