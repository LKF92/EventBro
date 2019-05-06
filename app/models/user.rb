class User < ApplicationRecord
  after_create :send_welcome

  has_many :events, foreign_key: "admin_id", class_name: "Event"
  has_many :attendances, foreign_key: "attendee_id", class_name: "Attendance"

  def send_welcome
    UserMailer.welcome_email(self).deliver_now
  end
end
