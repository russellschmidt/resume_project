class SchoolsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :resume_find

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
    @school = @resume.schools.build(school_params)

    if @school.save
      redirect_to resume_schools_path(@resume, @school)
    else
      render action: :new
    end
  end


  def edit
    #@resume = Resume.find(params[:resume_id])
    @school = @resume.schools.find(params[:id])
  end

  def update
    #@resume = Resume.find(params[:resume_id])
    @school = @resume.schools.find(params[:id])

    if @school.update_attributes(school_params)
      redirect_to resume_school_path(@resume, @school), notice: "Successful update"
    else
      render action: :edit
    end

  end

  def destroy
    #@resume = Resume.find(params[:resume_id])
    @school = @resume.schools.find(params[:id])

    if @school.destroy
      redirect_to resume_schools_url, notice: 'School deleted'
    else
      redirect_to resume_schools_path, notice: 'School delete failed'
    end
  end


  private
  def resume_find
    @resume = Resume.find(params[:resume_id])
  end

  # replace params[:school] with school_params in create, update
  def school_params
    params.require(:school).permit(:degree, :description, :end_date, :major, :school_name, :start_date)
  end
end
