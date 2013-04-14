class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.integer :user_id
      t.integer :resume_id
      t.string :school_name
      t.string :degree
      t.string :major
      t.text :description
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
