class AddTopContentAndBottomContentToCustomForm < ActiveRecord::Migration[5.1]
  def change
    add_column :custom_forms, :top_content, :text
    add_column :custom_forms, :bottom_content, :text
  end
end
