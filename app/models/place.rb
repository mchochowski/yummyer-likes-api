# frozen_string_literal: true

class Place
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :image_url, type: String
  field :location, type: String
  field :rating, type: String
  field :type, type: String
  field :yelp_id, type: String

  validates :yelp_id, uniqueness: { scope: %i[user_id _type] }
end
