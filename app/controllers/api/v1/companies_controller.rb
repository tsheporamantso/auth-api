class API::V1::Companies_Controller < ApiController
  def index
    @company = Company.all
  end
end
