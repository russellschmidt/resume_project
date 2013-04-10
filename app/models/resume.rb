class Resume < ActiveRecord::Base
  attr_accessible :contact_id, :description, :job_id, :position, :resume_name, :school_id, :user_id

  belongs_to :user
end
