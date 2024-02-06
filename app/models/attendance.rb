class Attendance < ApplicationRecord
  has_one :user
  has_one :activity
  has_one :application
end
