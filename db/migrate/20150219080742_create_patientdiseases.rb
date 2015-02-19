class CreatePatientdiseases < ActiveRecord::Migration
  def change
    create_table :patientdiseases do |t|
      t.string :code
      t.string :disease
      t.references :patient, index: true

      t.timestamps null: false
    end
    add_foreign_key :patientdiseases, :patients
  end
end
