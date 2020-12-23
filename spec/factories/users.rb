# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::TvShows::BreakingBad.character.parameterize }
  end
end
