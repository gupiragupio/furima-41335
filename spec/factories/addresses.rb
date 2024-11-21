FactoryBot.define do
  factory :address do
    postal_code { "MyString" }
    prefecture_id { 1 }
    city { "MyString" }
    street { "MyString" }
    building { "MyString" }
    phone_number { "MyString" }
    order_log { nil }
  end
end