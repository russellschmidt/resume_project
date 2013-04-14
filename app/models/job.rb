class Job < ActiveRecord::Base
  attr_accessible :company, :description, :end_date, :start_date, :title, :user_id

  validates :description, :title, :company, :start_date, :presence => true

  belongs_to :resume
  belongs_to :user
end
