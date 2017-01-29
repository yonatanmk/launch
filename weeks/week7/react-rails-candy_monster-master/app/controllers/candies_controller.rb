class CandiesController < ApplicationController

  def create
    @candy = Candy.new(candy_params)
    if @candy.save!
      flash[:notice] = "Candy successfully added!"
      redirect_to candy_path(@candy)
    else
      flash[:error] = @candy.errors.full_messages.join('. ')
      render :new
    end
  end

  def index
    @candy = Candy.new
    @candies = Candy.all
  end

  def show
    @candy = Candy.find(params[:id])
  end

  private

  def candy_params
    params.require(:candy).permit(:name, :description, :image_url)
  end
end
