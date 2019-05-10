  class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
    after_create :send_welcome

    has_many :events, foreign_key: "admin_id", class_name: "Event"
    has_many :attendances, foreign_key: "attendee_id", class_name: "Attendance"

    def send_welcome
      UserMailer.welcome_email(self).deliver_now
    end
  end