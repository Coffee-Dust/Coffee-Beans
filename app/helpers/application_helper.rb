module ApplicationHelper
  def error_message_for_field(field_name, object)
    if object.errors.present?
      return object.errors.full_messages_for(field_name).first
    else
      return nil
    end
  end
end
