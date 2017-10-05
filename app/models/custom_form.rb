class CustomForm < ApplicationRecord
  has_many :custom_inputs
  has_many :form_records

  validates_presence_of :name

  def new
    @input = InputModel.create.new(custom_inputs)
  end
end
