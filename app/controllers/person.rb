class Person < Documentary::BaseController
  def index
    #puts self.class.instance_variable_get(:@params)
    #puts self.class.print_params['index'].inspect
    Response.new.tap do |response|
      response.body = 'Custom index'
      response.status_code = 200
    end
  end
  params :index do
    optional(:name)
    required(:title)
    required(:salutation, type: Integer, desc: 'Type of expected invocation for this person')
    required(:friends, type: Array) do
      optional :name
      optional :gender
    end
  end

  def show
    Response.new.tap do |response|
      response.body = 'Catchall Route'
      response.status_code = 200
    end
  end
  params :show do
    optional(:start_date)
  end
end
