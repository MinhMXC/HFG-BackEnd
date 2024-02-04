class Activity < ApplicationRecord
  validates :title, :overview, :body, :manpower_needed, :location, :time_start, :time_end, presence: true
  has_many :applications
  has_many :attendances
  has_many :users, :through => :applications
  has_many :users, :through => :attendances
end
