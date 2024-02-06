class Application < ApplicationRecord
  has_one :user
  has_one :activity
end