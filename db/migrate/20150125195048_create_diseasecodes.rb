class CreateDiseasecodes < ActiveRecord::Migration
  def change
    create_table :diseasecodes do |t|
      t.string :disease
      t.string :code
      t.integer :hospitaladmin_id
      t.text :description

      t.timestamps null: false
    end
  end
end
