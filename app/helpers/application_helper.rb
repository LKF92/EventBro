module ApplicationHelper
  def not_admin_nor_attending
    current_user != @event.admin && !Attendance.where(attendee_id: current_user.id, event_id: @event.id).exists?
    end
end
