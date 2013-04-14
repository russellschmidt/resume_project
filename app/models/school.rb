class School < ActiveRecord::Base
  attr_accessible :degree, :description, :end_date, :major, :resume_id, :school_name, :start_date, :user_id

  belongs_to :resume
  belongs_to :user

  validates :degree, :major, :school_name, :start_date, :presence => true
end
