class Permission < ActiveRecord::Base
  validates :scope, uniqueness: { scope: :user,  message: "should be unique by user" }
  validates_presence_of :user
  validates_presence_of :scope

  belongs_to :user
  belongs_to :scope
end