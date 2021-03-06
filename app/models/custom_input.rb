class CustomInput < ApplicationRecord
  INPUT_TYPES = {
    text_field: { name: 'テキスト' },
    text_area: { name: 'テキストエリア（複数行）' },
    last_first_name: { name: '姓名別氏名' },
    kana_text_field: { name: 'テキスト（カタカナ）',
                       validates_kana_format: true },
    calendar_date: { name: '日付（カレンダー）' },
    select: { name: 'セレクト（単一選択）' },
    radio_buttons: { name: 'ラジオ（単一選択）' },
    check_boxes: { name: 'チェックボックス（複数選択）' },
  }
  INPUT_TYPE_OPTIONS = INPUT_TYPES.map { |k, v| [k.to_s, v[:name]] }.to_h

  belongs_to :custom_form
  validates_presence_of :label, :input_type
  validates :options, presence: true, if: proc { input_type.match(/(boxes|buttons|select)\Z/) }

  def attr_names
    base_name = "custom_input_#{id}"
    case input_type.to_sym
    when :last_first_name
      [base_name + '_last_name', base_name + '_first_name']
    else
      Array(base_name)
    end
  end

  def params_permits
    attr_names.map do |n|
      if input_type == 'check_boxes'
        {n => []}
      else
        n
      end
    end
  end

  def field_input_params(value_hash)
    {label: label,
     value: input_type_value(value_hash),
     input_type: input_type,
     order: order}
  end

  def init_input(input_model)
    input = self
    type_info = INPUT_TYPES[input.input_type.to_sym] || {}
    input_model.class_eval {
      input.attr_names.map do |attr_name|
        attr_accessor attr_name
        validates_presence_of attr_name if input.required
        validates attr_name, format: { with: Regexp.new( /\A[ァ-ンー－]+\z/), allow_blank: true } if type_info[:validates_kana_format]
      end
    }
  end

  private

  def input_type_value(value_hash)
    case input_type.to_s
    when /last_first_name\Z/
      value_hash.values.join(' ')
    when /check_boxes\Z/
      value_hash.values.first.join(',')
    else
      value_hash.values.first
    end
  end
end
