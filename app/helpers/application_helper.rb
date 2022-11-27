module ApplicationHelper
  def bootstrap_class_for(flash_type)
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert alert-dismissible #{bootstrap_class_for(msg_type)}", role: "alert") do
        concat content_tag(:button, nil, class: "btn-close", data: { bs_dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  def form_builder(object, object_name, options = {})
    ActionView::Helpers::FormBuilder.new(object_name, object, self, options)
  end
end
