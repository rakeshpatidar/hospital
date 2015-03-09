class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :patientmsgs, :id, :text_msg_id
  end
end
