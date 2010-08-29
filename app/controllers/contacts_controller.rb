class ContactsController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  layout 'admin' 

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
  #  layout 'application'
    @contact = Contact.new
    @scores = Game.random_scores

    respond_to do |format|
      format.html { render :layout => 'layouts/application'}  # new.html.erb 
      format.xml  { render :xml => @contact }
    end
  end
  
  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        format.html { redirect_to '/thanks' } # issue on production server sends to https.  not sure why
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  # GET /contacts
  # GET /contacts.xml
  def index
    @contacts = Contact.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end
  
  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end
  
  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end
  
end
