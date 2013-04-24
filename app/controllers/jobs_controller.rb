class JobsController < ApplicationController
before_filter :authenticate_user!
before_filter :resume_find

  
  def index
    #@resume = Resume.find(params[:resume_id])
    @jobs = @resume.jobs.all
  end

  def show
    #@resume = Resume.find(params[:resume_id])
    @job = @resume.jobs.find(params[:id])
  end


  def new
    #@resume = Resume.find(params[:resume_id])
    @job = @resume.jobs.build
  end

  def create
    #@resume = Resume.find(params[:resume_id])
    @job = @resume.jobs.build(job_params)

    if @job.save
      redirect_to [@resume, @job], notice: "Successful save"
    else
      render action: :new
    end
  end


  def edit
    #@resume = Resume.find(params[:resume_id])
    @job = @resume.jobs.find(params[:id])
  end

  def update
    #@resume = Resume.find(params[:resume_id])
    @job = @resume.jobs.find(params[:id])

    if @job.update_attributes(job_params)
      redirect_to resume_job_path(@resume, @job), notice: "Successful update"
    else
      render action: :edit
    end

  end

  def destroy
    #@resume = Resume.find(params[:resume_id])
    @job = @resume.jobs.find(params[:id])

    if @job.destroy
      redirect_to resume_jobs_url, notice: 'Job deleted'
    else
      redirect_to resume_jobs_path, notice: 'Job delete failed'
    end
  end


  private
  def resume_find
    @resume = Resume.find(params[:resume_id])
  end

  # replace params[:job] with job_params in create, update
  def job_params
    params.require(:job).permit(:company, :description, :end_date, :start_date, :title)
  end
end