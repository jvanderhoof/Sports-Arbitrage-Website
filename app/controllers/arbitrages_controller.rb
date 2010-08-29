class ArbitragesController < ApplicationController
  before_filter :login_required
  layout'admin' 
  
  # GET /arbitrages
  # GET /arbitrages.xml
  def index
    @arbitrages = Arbitrage.open_arbs
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @arbitrages }
    end
  end

  # GET /arbitrages/1
  # GET /arbitrages/1.xml
  def show
    @arbitrage = Arbitrage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @arbitrage }
    end
  end

  # GET /arbitrages/new
  # GET /arbitrages/new.xml
  def new
    @arbitrage = Arbitrage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @arbitrage }
    end
  end

  # GET /arbitrages/1/edit
  def edit
    @arbitrage = Arbitrage.find(params[:id])
  end

  # POST /arbitrages
  # POST /arbitrages.xml
  def create
    @arbitrage = Arbitrage.new(params[:arbitrage])

    respond_to do |format|
      if @arbitrage.save
        flash[:notice] = 'Arbitrage was successfully created.'
        format.html { redirect_to(@arbitrage) }
        format.xml  { render :xml => @arbitrage, :status => :created, :location => @arbitrage }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @arbitrage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /arbitrages/1
  # PUT /arbitrages/1.xml
  def update
    @arbitrage = Arbitrage.find(params[:id])

    respond_to do |format|
      if @arbitrage.update_attributes(params[:arbitrage])
        flash[:notice] = 'Arbitrage was successfully updated.'
        format.html { redirect_to(@arbitrage) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @arbitrage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /arbitrages/1
  # DELETE /arbitrages/1.xml
  def destroy
    @arbitrage = Arbitrage.find(params[:id])
    @arbitrage.destroy

    respond_to do |format|
      format.html { redirect_to(arbitrages_url) }
      format.xml  { head :ok }
    end
  end
end
