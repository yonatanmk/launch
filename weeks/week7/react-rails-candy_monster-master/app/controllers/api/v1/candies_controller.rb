class Api::V1::CandiesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    render json: Candy.all
  end

  def update
    candy = Candy.find(params[:id])
    candy.points += 1
    if candy.save!
      render json: candy
    end
  end

  def show
    candy = Candy.find(params[:id])
    render json: candy
  end

  def candy_params
    params.require(:candy).permit(:id, :name, :points)
  end
end
