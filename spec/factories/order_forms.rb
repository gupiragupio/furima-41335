FactoryBot.define do
  factory :order_form do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    street { '青山1-1-1' }
    building { '青山ビル' }
    phone_number { '09012345678' }
    token { 'tok_test' } # モック用トークンをここで指定
  end
end
