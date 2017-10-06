module CustomFormsHelper
  def custom_form(f, item)
    contents =
      case item.input_type.to_sym
      when :text_area
        f.text_area(item.attr_names.first, class: 'form-control')
      when :select
        f.select(item.attr_names.first, item.options.split(','))
      when :radio_buttons
        f.collection_radio_buttons(item.attr_names.first, item.options.split(','), :to_s, :to_s)
      when :check_boxes
        f.collection_check_boxes(item.attr_names.first, item.options.split(','), :to_s, :to_s)
      when :last_first_name
        content_tag(:div, class: 'form-inline') do
          (
            content_tag(:div, class: 'mr-2') do
              ('姓' + f.text_field(item.attr_names.first, class: 'form-control')).html_safe
            end +
            content_tag(:div) do
              ('名' + f.text_field(item.attr_names.second, class: 'form-control')).html_safe
            end
          ).html_safe
        end
      else
        f.text_field(item.attr_names.first, class: 'form-control')
      end
    render partial: 'shared/inputs/layout', locals: { f: f, item: item, contents: contents }
  end
end
