class ReferalsController < ApplicationController
  before_filter :login_required
  layout'admin' 

  # GET /referals
  # GET /referals.xml
  def index
    @referals = Referal.find(:all, :limit => 50, :order => "created_at desc")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @referals }
    end
  end

  # GET /referals/1
  # GET /referals/1.xml
  def show
    @referal = Referal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @referal }
    end
  end

  # GET /referals/new
  # GET /referals/new.xml
  def new
    @referal = Referal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @referal }
    end
  end

  # GET /referals/1/edit
  def edit
    @referal = Referal.find(params[:id])
  end

  # POST /referals
  # POST /referals.xml
  def create
    @referal = Referal.new(params[:referal])

    respond_to do |format|
      if @referal.save
        flash[:notice] = 'Referal was successfully created.'
        format.html { redirect_to(@referal) }
        format.xml  { render :xml => @referal, :status => :created, :location => @referal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @referal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /referals/1
  # PUT /referals/1.xml
  def update
    @referal = Referal.find(params[:id])

    respond_to do |format|
      if @referal.update_attributes(params[:referal])
        flash[:notice] = 'Referal was successfully updated.'
        format.html { redirect_to(@referal) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @referal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /referals/1
  # DELETE /referals/1.xml
  def destroy
    @referal = Referal.find(params[:id])
    @referal.destroy

    respond_to do |format|
      format.html { redirect_to(referals_url) }
      format.xml  { head :ok }
    end
  end
end
