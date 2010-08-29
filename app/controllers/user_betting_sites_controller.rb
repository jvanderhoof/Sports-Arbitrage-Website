class UserBettingSitesController < ApplicationController
  # GET /user_betting_sites
  # GET /user_betting_sites.xml
  def index
    
    @user_betting_sites = UserBettingSite.find(:all, :conditions => ["user_id = ?", session[:user_id]])
    @betting_sites = BettingSite.find(:all, :order => :name)
    @user_betting_site = UserBettingSite.new
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_betting_sites }
    end
  end

  # GET /user_betting_sites/1
  # GET /user_betting_sites/1.xml
  def show
    @user_betting_site = UserBettingSite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_betting_site }
    end
  end

  # GET /user_betting_sites/new
  # GET /user_betting_sites/new.xml
  def new
    @user_betting_site = UserBettingSite.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_betting_site }
    end
  end

  # GET /user_betting_sites/1/edit
  def edit
    @user_betting_site = UserBettingSite.find(params[:id])
  end

  # POST /user_betting_sites
  # POST /user_betting_sites.xml
  def create
    
    user = User.find(session[:user_id])
    user.user_betting_sites.each {|site| site.delete}
    params[:items].keys.each {|site| UserBettingSite.create({:user_id => user.id, :betting_site_id => site.to_i})} unless params[:items].nil?
    flash[:notice] = 'Your Betting Site selections were successfully updated.'
    redirect_to :controller => 'users', :action => 'index'
=begin      
    @user_betting_site = UserBettingSite.new(params[:user_betting_site])
    
    respond_to do |format|
      if @user_betting_site.save
        flash[:notice] = 'UserBettingSite was successfully created.'
        format.html { redirect_to(@user_betting_site) }
        format.xml  { render :xml => @user_betting_site, :status => :created, :location => @user_betting_site }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_betting_site.errors, :status => :unprocessable_entity }
      end
    end
=end
  end

  # PUT /user_betting_sites/1
  # PUT /user_betting_sites/1.xml
  def update
    @user_betting_site = UserBettingSite.find(params[:id])

    respond_to do |format|
      if @user_betting_site.update_attributes(params[:user_betting_site])
        flash[:notice] = 'UserBettingSite was successfully updated.'
        format.html { redirect_to(@user_betting_site) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_betting_site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_betting_sites/1
  # DELETE /user_betting_sites/1.xml
  def destroy
    @user_betting_site = UserBettingSite.find(params[:id])
    @user_betting_site.destroy

    respond_to do |format|
      format.html { redirect_to(user_betting_sites_url) }
      format.xml  { head :ok }
    end
  end
end
