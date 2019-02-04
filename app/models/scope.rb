class Scope < ActiveRecord::Base
  validates :name, uniqueness: {case_sensitive: false}
  validates_presence_of :name

  has_many :permissions
  has_many :users, through: :permissions, dependent: :destroy

  def list_users
    users.map do |user|
      {id: user.id, user_name: user.user_name}
    end
  end

  class << self
    def find_by_name(name)
      Scope.where(name: name).first
    end

    def add_scope(name)
      Scope.create!(name: name)
    end

    def find_by_id(id)
      Scope.where(id: id).first
    end

    def list_scopes
      Scope.all.map do |scope|
        {id: scope.id, name: scope.name}
      end
    end

    def delete_scope(id)
      Scope.destroy(id)
    end
  end
end
