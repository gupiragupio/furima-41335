class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '食品' },
    { id: 2, name: '飲料' },
    { id: 3, name: '家電' }
    # 他のカテゴリーも必要に応じて追加
  ]
end
