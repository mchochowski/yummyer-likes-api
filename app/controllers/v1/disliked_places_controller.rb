# frozen_string_literal: true

module V1
  class DislikedPlacesController < ApplicationController
    include Pageable

    before_action :set_current_user
    before_action :set_disliked_place, only: %i[destroy]

    def index
      @disliked_places = @current_user.disliked_places.order(created_at: :desc)
                                      .offset(offset).limit(limit)
      total = @current_user.disliked_places.count

      render json: PlaceSerializer.new(@disliked_places, page_data(total)).serializable_hash.to_json
    end

    def create
      @disliked_place = @current_user.disliked_places.new(disliked_place_params)

      if @disliked_place.save
        render json: PlaceSerializer.new(@disliked_place).serializable_hash.to_json,
               status: :created
      else
        render json: @disliked_place.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @disliked_place.destroy
    end

    private

    def set_current_user
      @current_user = User.find_by(username: params[:username])
    end

    def set_disliked_place
      @disliked_place = DislikedPlace.find(params[:id])
    end

    def disliked_place_params
      params.require(:disliked_place).permit(:name, :image_url, :location, :rating, :yelp_id)
    end

    def query_params(new_offset: nil)
      { username: params[:username], limit: limit, offset: new_offset || offset }
    end

    def endpoint_url(*args)
      v1_disliked_places_url(*args)
    end
  end
end
