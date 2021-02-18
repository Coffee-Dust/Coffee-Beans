module ApplicationHelper
  def error_message_for_field(field_name, object)
    if object.errors.present?
      return object.errors.full_messages_for(field_name).first
    else
      return nil
    end
  end

  def check_and_display_alert(object=nil)
    if flash[:alert].present?
      message = flash[:alert]

      render(partial: "application/error_display_ribbon", locals: {message: message})
    end
  end
end
