class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  #include AuthenticatedSystem
  before_filter :login_required
  layout'admin' 

  # render new.rhtml
  def new
    @user = User.new
  end
  
  def index
    @user = User.find(session[:user_id])
    unless @user.nil?

      @user_teams = UserTeam.find(:all, :conditions => ["user_id = ?", session[:user_id]])
      @sports = Sport.find(:all, :order => :name)
      @user_team = UserTeam.new
      @user_team.user_id = session[:user_id]
      
      @user_betting_sites = UserBettingSite.find(:all, :conditions => ["user_id = ?", session[:user_id]])
      @betting_sites = BettingSite.find(:all, :conditions => 'active = 1', :order => :name)
      @user_betting_site = UserBettingSite.new
      
    end
  end

  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      #self.current_user = @user # !! now logged in - to create new users
      post("/sessions/create", {:login => params[:login], :password=>params[:password]})
      #redirect_to("/sessions/create?login=#{params[:login]}&password=#{params}", :action => 'create', :username => params[:username])
      
      #redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end  
end
