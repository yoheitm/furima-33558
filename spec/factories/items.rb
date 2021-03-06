FactoryBot.define do
  factory :item do
    name                      { Faker::Lorem.words }
    info                      { Faker::Lorem.characters }
    category_id               { 2 }
    state_id                  { 2 }
    ship_base_id              { 2 }
    area_id                   { 3 }
    ship_date_id              { 2 }
    price                     { 1000 }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/item-sample.png'), filename: 'item-sample.png')
    end
  end

end
