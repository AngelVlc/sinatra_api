class Scope < ActiveRecord::Base
  validates :name, uniqueness: { case_sensitive: false }
  validates_presence_of :name

  has_many :permissions
  has_many :users, through: :permissions
end