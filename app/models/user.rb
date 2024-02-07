# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :full_name, :handphone, :age, presence: true
  validates :is_male, inclusion: { in: [ true, false ] }

  has_many :applications
  has_many :attendances
end
