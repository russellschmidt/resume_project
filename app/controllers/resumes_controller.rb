class ResumesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @resumes = current_user.resumes
  end

  def show
    @resume = current_user.resumes.find(params[:id])

    # actions for rendering as PDF via Prawn here
    respond_to do |format|
      format.html
      format.pdf do 
        # traditional resume
        pdf = ResumePdf.new(@resume)
        send_data pdf.render, filename: "#{@resume.resume_name}.pdf", 
          type: "application/pdf", disposition: "inline"
        
      end
    end

  end


  def new
    @resume = Resume.new
  end

  def create
    @resume = current_user.resumes.build(params[:resume])

    if @resume.save
      redirect_to @resume, notice: 'Resume created'
    else
      render action: :new
    end
  end


  def edit
    @resume = Resume.find(params[:id])
  end

  def update
    @resume = Resume.find(params[:id])

    if @resume.update_attributes(params[:resume])
      redirect_to @resume, notice: 'Resume update successful'
    else
      render action: :edit
    end
  end

  def destroy
    @resume = Resume.find(params[:id])
    
    if @resume.destroy
      redirect_to resumes_url, notice: 'Resume deleted'
    else
      redirect_to @resume, notice: 'Resume delete failed'
    end
  end

  #strong_parameters method for all former (params[:resume])
  #private 
  #def resume_params
  #  params.require(:resume).permit(:description, :position, :resume_name)
  #end
end
