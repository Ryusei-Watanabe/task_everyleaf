FactoryBot.define do
  factory :user do
    name { "user" }
    email { "user@sample.com" }
    password { "aaaaaa" }
    password_confirmation { "aaaaaa" }
    admin { false }
  end
  factory :admin_user, class: User do
    name { "admim_user" }
    email { "admin@sample.com" }
    password { "aaaaaa" }
    password_confirmation { "aaaaaa" }
    admin { true }
  end
end
