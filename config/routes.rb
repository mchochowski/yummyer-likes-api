# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    resources :liked_places, only: %w[index show create destroy]
    resources :disliked_places, only: %w[index show create destroy]
  end
end
