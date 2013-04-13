class JobsController < ApplicationController
before_filter :authenticate_user!
  
  def index
    @resume = Resume.find(params[:resume_id])
    @jobs = @resume.jobs.all
  end

  def show
    @resume = Resume.find(params[:resume_id])
    @job = @resume.jobs.find(params[:id])
  end


  def edit
    @resume = Resume.find(params[:resume_id])
    @job = @resume.jobs.find(params[:id])
  end

  def update
    @resume = Resume.find(params[:resume_id])
    @job = @resume.jobs.find(params[:id])
    if @job.update_attributes(params[:resume])
      redirect_to resume_job_path(@resume, @job)
    else
      render action: :edit
    end

  end


  def new
    @resume = Resume.find(params[:resume_id])
    @job = @resume.jobs.build
  end

  def create
    @resume = Resume.find(params[:resume_id])
    @job = @resume.jobs.build(params[:job])

    if @job.save
      redirect_to resume_job_path(@resume, @job)
    else
      render action: :new
    end
  end
end