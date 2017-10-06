module CustomFormsHelper
  def custom_form(f, item)
    contents =
      case item.input_type.to_sym
      when :text_area
        f.text_area(item.attr_names.first)
      when :select
        f.select(item.attr_names.first, item.options.split(','))
      when :radio_buttons
        f.collection_radio_buttons(item.attr_names.first, item.options.split(','), :to_s, :to_s)
      when :check_boxes
        f.collection_check_boxes(item.attr_names.first, item.options.split(','), :to_s, :to_s)
      when :last_first_name
        '姓' + f.text_field(item.attr_names.first) + ' 名' + f.text_field(item.attr_names.second)
      else
        f.text_field(item.attr_names.first)
      end
    render partial: 'shared/inputs/layout', locals: { f: f, item: item, contents: contents }
  end
end
