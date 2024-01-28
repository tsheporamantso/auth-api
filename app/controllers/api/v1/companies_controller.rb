class Api::V1::CompaniesController < ApiController
  
  before_action :set_company, only: [:show, :edit]
  
  def index
    # @companies = Company.all
    @companies = current_user.companies
    render json: @companies 
  end

  def show
    render json: @company
  end

  def new
    @company = Company.new
    render json: @company
  end

  def create
    @company = Company.new(company_params)

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
    @company = Company.find(company_params)
    # @company = current_user.companies.find(company_params)

    if @company.update
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

  private

  def set_company
    # @company = Company.find(params[id])
    @company = current_user.companies.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :address, :established_year, :user_id)
  end
end
