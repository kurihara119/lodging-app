class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :number_people, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true

  validate :date_before_start
  validate :date_before_end

  def date_before_start
    now = Date.today
    errors.add(:end_day, "過去の日付は無効です") if (start_day < now) || (end_day < now)
  end

  def date_before_end
    errors.add(:end_day, "は開始日より後にしてください") if end_day < start_day
  end

  def amount_day
    self.end_day - self.start_day
  end
  
  def amount_price
    self.room.price * self.number_people * self.stay_day
  end
end
