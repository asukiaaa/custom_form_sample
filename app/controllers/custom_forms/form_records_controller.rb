class CustomForms::FormRecordsController < ApplicationController
  before_action :set_custom_form
  before_action :set_form_record, only: [:show, :finished, :destroy]

  def index
    @form_records = @custom_form.form_records
  end

  def show
  end

  def new
    @form_record = FormRecord.new
    @record_data = @custom_form.new
  end

  def confirmation
    @record_data = new_record_data
    unless @record_data.valid?
      render :new
    end
  end

  def create
    @record_data = new_record_data
    if @record_data.valid? and params[:edit_again].blank?
      @form_record.data = @record_data.to_data.to_json
      @form_record.save
      redirect_to [:finished, @custom_form, @form_record]
    else
      render :new
    end
  end

  def finished
  end

  def destroy
    @form_record.destroy
    redirect_to [@custom_form, :form_records]
  end

  private

  def set_custom_form
    @custom_form = CustomForm.find(params[:custom_form_id])
  end

  def set_form_record
    @form_record = @custom_form.form_records.find(params[:id])
  end

  def form_record_params
    params.require(:input).permit(@custom_form.custom_inputs.map(&:params_permits).inject(&:+))
  end

  def new_record_data
    @form_record = @custom_form.form_records.new
    record_data = @custom_form.new
    record_data.input_attributes = form_record_params
    record_data
  end
end
