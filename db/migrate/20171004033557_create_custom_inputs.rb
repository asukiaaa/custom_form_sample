class CreateCustomInputs < ActiveRecord::Migration[5.1]
  def change
    create_table :custom_inputs do |t|
      t.string :label, null: false
      t.boolean :required
      t.string :input_type, null: false
      t.integer :order
      t.references :custom_form, foreign_key: true
      t.text :options
      t.text :comment

      t.timestamps
    end
  end
end
