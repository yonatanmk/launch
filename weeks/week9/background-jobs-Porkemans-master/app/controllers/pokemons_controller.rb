class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]

  # GET /pokemons
  def index
    @pokemons = Pokemon.all
  end

  def report
    ReportWorker.perform_async
    render text: "REQUEST ADDED TO THE QUE DAWG!"
    # redirect_to pokemons_path
  end

  # GET /pokemons/1
  def show
    AutoCatchJob.perform_later
  end

  # GET /pokemons/new
  def new
    @pokemon = Pokemon.new
  end

  # GET /pokemons/1/edit
  def edit
  end

  # POST /pokemons
  def create
    @pokemon = Pokemon.new(pokemon_params)

    if @pokemon.save
      redirect_to @pokemon, notice: 'Pokemon was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /pokemons/1
  def update
    if @pokemon.update(pokemon_params)
      redirect_to @pokemon, notice: 'Pokemon was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pokemons/1
  def destroy
    @pokemon.destroy
    redirect_to pokemons_url, notice: 'Pokemon was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pokemon_params
      params.require(:pokemon).permit(:name)
    end
end
