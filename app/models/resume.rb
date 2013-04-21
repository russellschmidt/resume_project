class Resume < ActiveRecord::Base
  attr_accessible :contact_id, :description, :job_id, :position, :resume_name, :school_id, :user_id

  validates :description, :position, :resume_name, :presence => true

  belongs_to :user
  has_many :jobs
  has_many :schools
  has_many :contacts
end
