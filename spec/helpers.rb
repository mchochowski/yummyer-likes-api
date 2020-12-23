# frozen_string_literal: true

module Helpers
  def parsed_response
    Oj.load(response.body)
  end
end
