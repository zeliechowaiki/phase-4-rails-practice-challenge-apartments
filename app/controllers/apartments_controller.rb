class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    render json: Apartment.all
  end

  def show
    render json: Apartment.find(params[:id]), status: :ok
  end

  def create
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
  end

  def update
    apartment = Apartment.find(params[:id])
    apartment.update!(apartment_params)
    render json: apartment, status: :ok
  end

  def destroy
    Apartment.find(params[:id]).destroy
    head :no_content
  end

  private

  def render_not_found_response(invalid)
    render json: {errors: invalid.message}, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end

  def apartment_params
    params.permit(:number)
  end

end
