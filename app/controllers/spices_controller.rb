class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :if_not_found

    def index
        spices = Spice.all
        render json: spices
    end

    def create
        new_spice = Spice.create(spice_params)
        render json: new_spice, status: :created
    end

    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def find_spice
        Spice.find(params[:id])
    end

    def if_not_found
        render json: {error: "Spice not found"}, status: :not_found
    end
end
