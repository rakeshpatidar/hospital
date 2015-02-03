class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :hospitaladmin_id
      t.string :gender
      t.string :date_of_birth
      t.string :contact_no
      t.string :billing_id
      t.integer :discharge_status
      t.string :physician

      t.timestamps null: false
    end
  end
end
