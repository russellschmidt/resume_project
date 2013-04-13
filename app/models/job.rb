class Job < ActiveRecord::Base
  attr_accessible :company, :description, :end_date, :start_date, :title, :user_id

  belongs_to :resume
end
