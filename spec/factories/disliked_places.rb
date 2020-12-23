# frozen_string_literal: true

FactoryBot.define do
  factory :disliked_place do
    user { create(:user) }
    name { Faker::Restaurant.name }
    image_url { Faker::Internet.url }
    location { Faker::Address.full_address }
    rating { '4.5' }
    yelp_id { Faker::Internet.uuid }
  end
end
