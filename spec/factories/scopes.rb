FactoryBot.define do
  factory :scope_admin, class: Scope do
    name { "admin" }
  end

  factory :scope_test, class: Scope do
    name { "test" }
  end
end
