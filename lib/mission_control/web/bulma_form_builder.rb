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

  def submit(value = nil, options = {})
    div_control do
      super(value, merge_class(options, "button"))
    end
  end

  def submit_primary(value = nil, options = {})
    submit(value, merge_class(options, "is-primary"))
  end

  def div_control
    @template.content_tag(:div, class: "control") do
      yield
    end
  end

  def select_with_label(method, choices = nil, options = {}, html_options = {}, &block)
    label_default(method) + select(method, choices, options, html_options, &block)
  end

  def select(method, choices = nil, options = {}, html_options = {}, &block)
    label(method, class: "select") do
      super
    end
  end

  private
    def merge_class_attribute_value(options, value)
      new_options = options.clone
      new_options[:class] = [ value, new_options[:class] ].join(" ")
      new_options
    end

    alias_method :merge_class, :merge_class_attribute_value
end
