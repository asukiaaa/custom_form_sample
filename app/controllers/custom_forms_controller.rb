class CustomFormsController < ApplicationController
  before_action :set_custom_form, only: [:show, :edit, :update, :destroy]
  before_action :set_blank_custom_input

  def index
    @custom_forms = CustomForm.all
  end

  def show
  end

  def new
    @custom_form = CustomForm.new
    @custom_inputs = [@blank_custom_input]
  end

  def edit
    @custom_inputs = @custom_form.custom_inputs
  end

  def create
    @custom_form = CustomForm.new()

    begin
      validate_and_save
    rescue
      set_blank_custom_input
      render :new
      return
    else
      redirect_to @custom_form
    end
  end

  def update
    begin
      validate_and_save
    rescue
      set_blank_custom_input
      render :edit
      return
    end
    redirect_to @custom_form
  end

  def destroy
    @custom_form.destroy
    redirect_to custom_forms_url
  end

  private

  def validate_and_save
    ActiveRecord::Base.transaction do
      @custom_form.assign_attributes(custom_form_params)
      @custom_form.custom_inputs.destroy_all
      @custom_form.valid?
      @custom_inputs = custom_inputs_params.map { |input_params| @custom_form.custom_inputs.new(input_params) }
      @custom_inputs.map(&:valid?)
      @custom_form.save!
      @custom_inputs.map(&:save!)
    end
  end

  def set_custom_form
    @custom_form = CustomForm.find(params[:id])
  end

  def set_blank_custom_input
    @blank_custom_input = CustomInput.new
  end

  def custom_form_params
    params.require(:custom_form).permit(:name)
  end

  def raw_custom_inputs_params
    params.require(:custom_input).map { |p| p.permit(:label, :required, :input_type, :options, :comment) }
  end

  def custom_inputs_params
    raw_custom_inputs_params.each_with_index.map do |input_params, i|
      input_params.merge({order: i})
    end
  end
end
