module CustomFormsHelper
  def custom_form(f, item)
    contents =
      case item.input_type.to_sym
      when :text_area
        f.text_area(item.attr_names.first)
      when :last_first_name
        '姓' + f.text_field(item.attr_names[0]) + ' 名' + f.text_field(item.attr_names[1])
      else
        f.text_field(item.attr_names.first)
      end
    render partial: 'shared/inputs/layout', locals: { f: f, item: item, contents: contents }
  end
end
