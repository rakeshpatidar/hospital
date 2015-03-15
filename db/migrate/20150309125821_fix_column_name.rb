class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :patientmsgs, :id, :text_msg_id
  	rename_column :photomsgs, :id, :photomsg_id
  end
end
