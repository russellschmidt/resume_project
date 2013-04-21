class ContactsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :resume_find

  def index
    @contacts = @resume.contacts.all
  end

  def show
    @contact = @resume.contacts.find(params[:id])
  end



  def new
    @contact = @resume.contacts.build
  end

  def create
    @contact = @resume.contacts.build(params[:contact])

    if @contact.save
      redirect_to resume_contact_path(@resume, @contact)
    else
      render action: :new
    end
  end



  def edit
    @contact = @resume.contacts.find(params[:id])
  end

  def update
    @contact = @resume.contacts.find(params[:id])

    if @contact.update_attributes(params[:contact])
      redirect_to resume_contact_path(@resume, @contact), notice: "Successful update"
    else
      render action: :edit
    end
  end



  def destroy
    @contact = @resume.contacts.find(params[:id])

    if @contact.destroy
      redirect_to resume_contacts_url, notice: 'Contact info deleted'
    else
      redirect_to resume_contacts_path, notice: 'Contact delete failed'
    end
  end



  private
  def resume_find
    @resume = Resume.find(params[:resume_id])
  end
end