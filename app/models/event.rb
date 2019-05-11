  class Event < ApplicationRecord
    validates :start_date, presence: true
    validate :is_not_past

    validates :duration, presence: true
    validate :multiple_of_five

    validates :title, presence: true, length: 5..140
    validates :description, presence: true, length: 20..1000
    validates :price, presence: true, inclusion: {in: 0..1000}
    validates :location, presence: true


    has_many :attendances
    has_many :attendees, through: :attendances, class_name: "User"
    belongs_to :admin, class_name: "User"

    def is_not_past
      errors.add(:start_date, "can't be in the past") if start_date < Date.today
    end

    def multiple_of_five
      duration % 5 == 0
    end

    def is_free?
      self.price == 0
    end
  end


