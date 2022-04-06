class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def create
    lease = Lease.create!(lease_params)
    render json: lease, status: :created
  end

  def destroy
    Lease.find(params[:id]).destroy
    head :no_content
  end

  private

  def render_not_found_response(invalid)
    render json: {errors: invalid.message}, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end

  def lease_params
    params.permit(:rent, :tenant_id, :apartment_id)
  end

end
