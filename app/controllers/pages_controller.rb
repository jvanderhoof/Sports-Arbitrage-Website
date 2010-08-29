class PagesController < ApplicationController
  before_filter :login_required
  layout'admin' 

  # GET /page
  # GET /page.xml
  def index
    @pages = Page.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /page/1
  # GET /page/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /page/new
  # GET /page/new.xml
  def new
    @page = Page.new
    @page.active = true
    
    if (!params[:betting_site_id].nil?)
      @page.betting_site_id = params[:betting_site_id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /page/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /page
  # POST /page.xml
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Pages was successfully created.'
        format.html { redirect_to(:controller => 'betting_sites', :action => 'show', :id => @page.betting_site_id) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /page/1
  # PUT /page/1.xml
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Pages was successfully updated.'
        format.html { redirect_to(@page) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /page/1
  # DELETE /page/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(page_url) }
      format.xml  { head :ok }
    end
  end
end
