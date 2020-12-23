# frozen_string_literal: true

module V1
  class LikedPlacesController < ApplicationController
    include Pageable

    before_action :set_current_user
    before_action :set_liked_place, only: %i[destroy]

    def index
      @liked_places = @current_user.liked_places.order(created_at: :desc)
                                   .offset(offset).limit(limit)
      total = @current_user.liked_places.count

      render json: PlaceSerializer.new(@liked_places, page_data(total)).serializable_hash.to_json
    end

    def create
      @liked_place = @current_user.liked_places.new(liked_place_params)

      if @liked_place.save
        render json: PlaceSerializer.new(@liked_place).serializable_hash.to_json, status: :created
      else
        render json: @liked_place.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @liked_place.destroy
    end

    private

    def set_current_user
      @current_user = User.find_by(username: params[:username])
    end

    def set_liked_place
      @liked_place = LikedPlace.find(params[:id])
    end

    def liked_place_params
      params.require(:liked_place).permit(:name, :image_url, :location, :rating, :yelp_id)
    end

    def query_params(new_offset: nil)
      { username: params[:username], limit: limit, offset: new_offset || offset }
    end

    def endpoint_url(*args)
      v1_liked_places_url(*args)
    end
  end
end
