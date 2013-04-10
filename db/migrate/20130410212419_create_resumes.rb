class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.string :resume_name
      t.string :position
      t.string :description
      t.integer :job_id
      t.integer :school_id
      t.integer :contact_id
      t.integer :user_id

      t.timestamps
    end
  end
end
