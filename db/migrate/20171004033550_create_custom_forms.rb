class CreateCustomForms < ActiveRecord::Migration[5.1]
  def change
    create_table :custom_forms do |t|
      t.string :name
      t.text :form_top_html
      t.text :form_bottom_html
      t.text :confirmation_top_html
      t.text :confirmation_bottom_html
      t.text :finished_html

      t.timestamps
    end
  end
end
