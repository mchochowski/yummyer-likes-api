# frozen_string_literal: true

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String

  has_many :liked_places
  has_many :disliked_places
end
