class Car < Documentary::BaseController
  def index
    puts self.class.print_params[:index]
    Response.new.tap do |response|
      response.body = 'Car index'
      response.status_code = 200
    end
  end
  params :index do
    optional(:type)
    required(:vintage)
    required(:cc)
  end

  def show
    Response.new.tap do |response|
      response.body = 'Car edit'
      response.status_code = 200
    end
  end
  params :show do
    optional(:type)
    required(:vintage)
  end
end
