class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.string :title
      t.string :company
      t.date :start_date
      t.date :end_date
      t.text :description

      t.timestamps
    end
  end
end
