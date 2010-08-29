class SportsController < ApplicationController
  before_filter :login_required
  layout'admin' 

  # GET /sports
  # GET /sports.xml
  def index
    @sports = Sport.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sports }
    end
  end

  # GET /sports/1
  # GET /sports/1.xml
  def show
    @sport = Sport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sport }
    end
  end

  # GET /sports/new
  # GET /sports/new.xml
  def new
    @sport = Sport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sport }
    end
  end

  # GET /sports/1/edit
  def edit
    @sport = Sport.find(params[:id])
  end

  # POST /sports
  # POST /sports.xml
  def create
    @sport = Sport.new(params[:sport])

    respond_to do |format|
      if @sport.save
        flash[:notice] = 'Sport was successfully created.'
        format.html { redirect_to(:action => 'index') }
        format.xml  { render :xml => @sport, :status => :created, :location => @sport }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sports/1
  # PUT /sports/1.xml
  def update
    @sport = Sport.find(params[:id])

    respond_to do |format|
      if @sport.update_attributes(params[:sport])
        flash[:notice] = 'Sport was successfully updated.'
        format.html { redirect_to(:action => 'index') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sports/1
  # DELETE /sports/1.xml
  def destroy
    @sport = Sport.find(params[:id])
    @sport.destroy

    respond_to do |format|
      format.html { redirect_to(sports_url) }
      format.xml  { head :ok }
    end
  end
end
