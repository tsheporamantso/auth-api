class Api::V1::CompaniesController < ApiController
  load_and_authorize_resource
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  
  def index
    @companies = Company.accessible_by(current_ability)
    # @companies = current_user.companies
    render json: @companies, status: :ok 
  end

  def show
    render json: @company, status: :ok
  end

  def new
    @company = Company.new
    render json: @company
  end

  def create
    @company = Company.new(company_params)
    # @company = current_user.companies.new(company_params)

    if @company.save
     render json: {
       status: {
         code: 200,
         message: "Company created successfully"
       }
     }, status: :ok
    else
      render json: {
        status: {
          message: "Company could not be created",
          errors: @company.errors.full_messages
        }
      }, status: :unprocessable_entity
    end
  end

  def edit
    render json: @company
  end

  def update

    if @company.update(company_params)
      render json: {
        status: {
          code: 200,
          message: "Company details updated successfully"
        }
      }, status: :ok
    else
      render json: {
        status: {
          message: "Company details could not be updated",
          errors: @company.errors.full_messages
        }
      }, status: :unprocessable_entity
    end
  end

  def destroy
    if @company.destroy
    render json: {
      status: {
        code: 200,
        message: 'Company deleted successfully'
      }
    }, status: :ok
    else
      render json: { data: "Something went wrong", status: 'failured'}
    end
  end

  private

  def set_company
    # @company = Company.find(params[id])
    @company = current_user.companies.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
      render json: error.message, status: :unathorized 
  end

  def company_params
    params.require(:company).permit(:name, :address, :established_year)
  end
end
