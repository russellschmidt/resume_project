class SchoolsController < ApplicationController
  before_filter :authenticate_user!


  def index
      @resume = Resume.find(params[:resume_id])
      @schools = @resume.schools.all
  end

  def show
  end


  def new
  end

  def create
  end


  def edit
  end

  def update
  end


  def destroy
  end
end
