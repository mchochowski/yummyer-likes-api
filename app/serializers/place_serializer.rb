# frozen_string_literal: true

class PlaceSerializer
  include JSONAPI::Serializer
  attributes :name, :image_url, :location, :rating, :yelp_id, :_type
end
