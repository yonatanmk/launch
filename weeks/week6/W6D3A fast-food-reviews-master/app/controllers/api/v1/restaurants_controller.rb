class Api::V1::RestaurantsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @restaurants = Restaurant.all
    render json: @restaurants
  end

  def create
    data = JSON.parse(request.body.read)
    @restaurant = Restaurant.new(name: data["name"], category: data["category"], description: data["description"])
    if @restaurant.save!
      @restaurants = Restaurant.all
      @restaurants.order(:id)
      render json: @restaurants
    else
      render json: {message: "Did not work"}, status: 404
    end
  end

  def destroy
    data = JSON.parse(request.body.read)
    restaurant = Restaurant.find(data["id"])
    if restaurant.delete
      @restaurants = Restaurant.all
      @restaurants.order(:id)
      render json: @restaurants
    end
  end

  def update
    data = JSON.parse(request.body.read)
    restaurant = Restaurant.find(data["id"])
    if data["type"] == "up_vote"
      restaurant.up_votes += 1
      restaurant.save
      @restaurants = Restaurant.order(:id)
      render json: @restaurants
    elsif data["type"] == "down_vote"
      restaurant.down_votes += 1
      restaurant.save
      @restaurants = Restaurant.order(:id)
      render json: @restaurants
    end
  end
end
