FactoryBot.define do
  factory :user_purchase do
    postcode { '123-4567' }
    area_id { 2 }
    city { Gimei.address.city.kanji }
    block { Gimei.address.town.kanji }
    building { 'テストハウス' }
    phone_number { '12345678910' }
    user_id { 1 }
    item_id { 2 }
    token { 'tok_abcdefghijk0000000000000000' }
  end
end
