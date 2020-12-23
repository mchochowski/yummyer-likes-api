# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::DisDislikedPlaces' do
  let(:user) { FactoryBot.create(:user) }
  let(:yelp_id) { '_sTaigaHcK8Pb1e-IcgGzw' }
  let(:place_params) do
    {
      name: 'Jalapeños',
      image_url: 'https://s3-media1.fl.yelpcdn.com/bphoto/Uf5_15yurBHiKOUK5HlXbg/o.jpg',
      location: '5714 5th Ave, Sunset Park, NY 11220',
      rating: '4',
      yelp_id: yelp_id
    }
  end

  describe '#create' do
    let(:path) { '/v1/disliked_places' }

    context "when the place hasn't been liked before" do
      it 'has correct status' do
        post path, params: { username: user.username, disliked_place: place_params }
        expect(response).to be_created
      end

      it 'creates DislikedPlace' do
        expect do
          post path, params: { username: user.username, disliked_place: place_params }
        end.to change { DislikedPlace.count }.by 1
      end

      it 'returns details of created record' do
        post path, params: { username: user.username, disliked_place: place_params }
        expect(parsed_response['data']['attributes']['name']).to eq('Jalapeños')
      end

      it 'assigns DislikedPlace record to selected user' do
        post path, params: { username: user.username, disliked_place: place_params }
        created_place = DislikedPlace.find_by(id: parsed_response['data']['id'])
        expect(created_place.user).to eq(user)
      end
    end

    context 'when the place has been liked already' do
      before { FactoryBot.create(:disliked_place, yelp_id: yelp_id, user_id: user.id) }

      it 'has correct status' do
        post path, params: { username: user.username, disliked_place: place_params }
        expect(response.status).to eq(422)
      end

      it 'does not create DislikedPlace' do
        expect do
          post path, params: { username: user.username, disliked_place: place_params }
        end.to_not change(DislikedPlace, :count)
      end

      it 'returns error' do
        post path, params: { username: user.username, disliked_place: place_params }
        expect(parsed_response['yelp_id'][0]).to eq('is already taken')
      end
    end
  end

  describe '#index' do
    let(:host) { 'http://www.example.com' }
    before { FactoryBot.create_list(:disliked_place, 5, user_id: user.id) }

    context 'first page' do
      let(:path) { "/v1/disliked_places?username=#{user.username}&limit=2" }

      it 'is successful' do
        get path
        expect(response).to be_ok
      end

      it 'lists correct number of entities' do
        get path
        expect(parsed_response['data'].size).to eq 2
      end

      it 'lists entities of correc type' do
        get path
        expect(parsed_response['data'].sample['attributes']['_type']).to eq 'DislikedPlace'
      end

      it 'returns total number of results' do
        get path
        expect(parsed_response['meta']['total']).to eq 5
      end

      it 'has next link' do
        get path
        expect(parsed_response['links']['next'])
          .to eq "#{host}/v1/disliked_places?limit=2&offset=2&username=#{user.username}"
      end

      it 'does not have prev link' do
        get path
        expect(parsed_response['links']['prev']).to be_nil
      end
    end

    context 'second page' do
      let(:path) { "/v1/disliked_places?username=#{user.username}&limit=2&offset=2" }

      it 'is successful' do
        get path
        expect(response).to be_ok
      end

      it 'lists correct number of entities' do
        get path
        expect(parsed_response['data'].size).to eq 2
      end

      it 'lists entities of correc type' do
        get path
        expect(parsed_response['data'].sample['attributes']['_type']).to eq 'DislikedPlace'
      end

      it 'returns total number of results' do
        get path
        expect(parsed_response['meta']['total']).to eq 5
      end

      it 'has next link' do
        get path
        expect(parsed_response['links']['next'])
          .to eq "#{host}/v1/disliked_places?limit=2&offset=4&username=#{user.username}"
      end

      it 'has prev link' do
        get path
        expect(parsed_response['links']['prev'])
          .to eq "#{host}/v1/disliked_places?limit=2&offset=0&username=#{user.username}"
      end
    end

    context 'last page' do
      let(:path) { "/v1/disliked_places?username=#{user.username}&limit=2&offset=4" }

      it 'is successful' do
        get path
        expect(response).to be_ok
      end

      it 'lists correct number of entities' do
        get path
        expect(parsed_response['data'].size).to eq 1
      end

      it 'lists entities of correc type' do
        get path
        expect(parsed_response['data'].sample['attributes']['_type']).to eq 'DislikedPlace'
      end

      it 'returns total number of results' do
        get path
        expect(parsed_response['meta']['total']).to eq 5
      end

      it 'does not have next link' do
        get path
        expect(parsed_response['links']['next']).to be_nil
      end

      it 'has prev link' do
        get path
        expect(parsed_response['links']['prev'])
          .to eq "#{host}/v1/disliked_places?limit=2&offset=2&username=#{user.username}"
      end
    end
  end
end
