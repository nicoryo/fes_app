FactoryBot.define do
  factory :user do
    name { 'Alice#1' }
    email { 'alice@example.co.jp' }

    transient do
      password_is { '' }
      password_confirmation_is { '' }
    end
    password { password_is.to_s }
    password_confirmation { password_confirmation_is.to_s }
  end

  factory :alice, class: User do
    name { 'Alice#2' }
    email { 'alice2@example.co.jp' }
    password { 'password' }
    password_confirmation { 'password' }
    sex { '2' }
    birthday { '1991.1.1' }
    introduction { 'Hello my name is Alice' }
  end
end
