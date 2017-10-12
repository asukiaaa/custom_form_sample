class CreateRecordInputs < ActiveRecord::Migration[5.1]
  def change
    create_table :record_inputs do |t|
      t.references :form_record, foreign_key: true
      t.string :label
      t.text :value
      t.string :input_type
      t.integer :order

      t.timestamps
    end
  end
end
