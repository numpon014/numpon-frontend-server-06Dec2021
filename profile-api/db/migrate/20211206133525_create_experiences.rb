class CreateExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :experiences do |t|
      t.date :start_date
      t.date :end_date
      t.string :title
      t.string :company
      t.string :company_logo
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
