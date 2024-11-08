FactoryBot.define do
  factory :item do
    item_name             { 'テスト商品' }    # 商品名
    info                  { 'テスト説明' }    # 商品説明
    category_id           { 2 }              # カテゴリー
    state_id              { 2 }              # 商品の状態
    fee_id                { 2 }              # 配送料
    prefecture_id         { 2 }              # 発送元の地域
    time_to_delivery_id   { 2 }              # 発送までの日数
    price                 { 500 }            # 価格
    association :user # 誰が作ったかを一緒に登録する

    # 商品画像を追加
    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec/fixtures/test_image.png')), filename: 'test_image.png',
                        content_type: 'image/png')
    end
  end
end
