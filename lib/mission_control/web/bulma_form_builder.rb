# Inspired by https://medium.com/@dyanagi/a-bulma-form-builder-for-ruby-on-rails-applications-aef780808bab

class MissionControl::Web::BulmaFormBuilder < ActionView::Helpers::FormBuilder
  def label_default(method, text = nil, options = {}, &block)
    label(method, text, merge_class(options, "label"), &block)
  end

  def label_check_box(method, text = nil, options = {}, &block)
    label(method, text, merge_class(options, "checkbox"), &block)
  end

  def text_field(method, options = {})
    super(method, merge_class(options, "input"))
  end

  def text_field_with_label(method, options = {})
    label_default(method) + text_field(method, options)
  end

  # Submit button without colour
  def submit(value = nil, options = {})
    div_control do
      super(value, merge_class(options, "button"))
    end
  end

  # Submit button with the primary colour for most forms
  def submit_primary(value = nil, options = {})
    submit(value, merge_class(options, "is-primary"))
  end

  def div_control
    @template.content_tag(:div, class: "control") do
      yield
    end
  end

  private

  # @param options [Hash]
  # @param value [String]
  def merge_class_attribute_value(options, value)
    new_options = options.clone
    new_options[:class] = [ value, new_options[:class] ].join(" ")
    new_options
  end

  alias_method :merge_class, :merge_class_attribute_value
end
