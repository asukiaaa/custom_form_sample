class FormRecord < ApplicationRecord
  belongs_to :custom_form
  has_many :record_inputs, ->{ order(order: :asc) }
end
