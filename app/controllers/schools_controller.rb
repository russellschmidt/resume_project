class SchoolsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :resume_find, only: [:index, :show, :new, :create]

  def index
    #@resume = Resume.find(params[:resume_id])
    @schools = @resume.schools.all
  end

  def show
    #@resume = Resume.find(params[:resume_id])
    @school = @resume.schools.find(params[:id])
  end


  def new
    #@resume = Resume.find(params[:resume_id])
    @school = @resume.schools.build
  end

  def create
    #@resume = Resume.find(params[:resume_id])
    @school = @resume.schools.build(params[:school])

    if @school.save
      redirect_to resume_schools_path(@resume, @school)
    else
      render action: :new
    end
  end


  def edit
  end

  def update
  end


  def destroy
  end

  private
  def resume_find
    @resume = Resume.find(params[:resume_id])
  end
end
