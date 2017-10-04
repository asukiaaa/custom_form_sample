class CreateFormRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :form_records do |t|
      t.references :custom_form, foreign_key: true
      t.text :data

      t.timestamps
    end
  end
end
