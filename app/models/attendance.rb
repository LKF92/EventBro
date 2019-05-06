class Attendance < ApplicationRecord
  after_create :send_confirmation_attendance
  belongs_to :event
  belongs_to :attendee, class_name: "User"

  def send_confirmation_attendance(user)
    UserMailer.confirm_attendee(user).deliver_now
  end
end
