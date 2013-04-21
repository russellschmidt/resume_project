class Contact < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :email, :first_name, :homepage, :last_name, :middle_name, :phone, :resume_id, :state, :twitter, :user_id, :zip

  validates :address1, :city, :state, :zip, :first_name, :last_name, :phone, :email, :presence => true

  validates :email, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :message => "Make sure you are using a valid email address"}

  validates :homepage, :format => { :with => /\A[A-Za-z0-9.-]+\.[A-Za-z]+\z/}

  validates :twitter, :length => { :maximum => 15}

  validates :zip, :length => { :in => 5..10 }

  belongs_to :user
  belongs_to :resume
end
