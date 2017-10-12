class RemoveDataFromFormRecords < ActiveRecord::Migration[5.1]
  def change
    remove_column :form_records, :data, :text
  end
end
