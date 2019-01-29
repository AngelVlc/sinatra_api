class Scope < ActiveRecord::Base
  validates :name, uniqueness: { case_sensitive: false }
  validates_presence_of :name

  has_many :permissions
  has_many :users, through: :permissions, dependent: :destroy

  class << self
    def find_by_name(name)
      Scope.where(name: name).first
    end

    def add_scope(name)
      Scope.create!(name: name)
    end
  end
end