class Role < ApplicationRecord
  has_many :users, through: :roles
  has_many :roles
end
