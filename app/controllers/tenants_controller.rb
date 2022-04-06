class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    render json: Tenant.all
  end

  def show
    render json: Tenant.find(params[:id]), status: :ok
  end

  def create
    tenant = Tenant.create!(tenant_params)
    render json: tenant, status: :created
  end

  def update
    tenant = Tenant.find(params[:id])
    tenant.update!(tenant_params)
    render json: tenant, status: :ok
  end

  def destroy
    Tenant.find(params[:id]).destroy
    head :no_content
  end

  private

  def render_not_found_response(invalid)
    render json: {errors: invalid.message}, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end

  def tenant_params
    params.permit(:name, :age)
  end

end
