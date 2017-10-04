class CustomForm < ApplicationRecord
  has_many :custom_inputs
  has_many :form_records

  def new
    @input = InputModel.create.new(custom_inputs)
  end
end
