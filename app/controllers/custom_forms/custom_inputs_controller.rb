class CustomForms::CustomInputsController < ApplicationController
  before_action :set_custom_form
  before_action :set_custom_input, only: [:show, :edit, :update, :destroy]

  def index
    @custom_inputs = @custom_form.custom_inputs
  end

  def show
  end

  def new
    @custom_input = CustomInput.new
  end

  def edit
  end

  def create
    @custom_input = @custom_form.custom_inputs.new(custom_input_params)
    if @custom_input.save
      redirect_to [@custom_form, @custom_input]
    else
      render :new
    end
  end

  def update
    if @custom_input.update(custom_input_params)
      redirect_to [@custom_form, @custom_input]
    else
      render :edit
    end
  end

  def destroy
    @custom_input.destroy
    redirect_to [@custom_form, :custom_inputs]
  end

  private

  def set_custom_form
    @custom_form = CustomForm.find(params[:custom_form_id])
  end

  def set_custom_input
    @custom_input = @custom_form.custom_inputs.find(params[:id])
  end

  def custom_input_params
    params.require(:custom_input).permit(:label, :required, :input_type, :order, :options, :comment)
  end
end
