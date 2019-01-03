FactoryBot.define do
  factory :user do
    user_name { "user" }
    password { "pas" }

    after :build do |user|
      user.scopes = create_list(:scope_test, 1)
    end
  end

  factory :admin, class: User do
    user_name { "admin" }
    password { "pas" }

    after :build do |user|
      user.scopes = create_list(:scope_admin, 0)
    end
  end
end
