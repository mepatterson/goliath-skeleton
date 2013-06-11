Dir["./app/apis/**/*.rb"].each { |f| require f }

class API < Grape::API
  format :json
  default_format :json

  helpers do
    def logger
      API.logger
    end
  end

  before do
    # do something before every API call
  end

  after do
    # do something after every API call
  end

  # mount APIv1::Unlocks
  
  resource 'servicehealth' do
    # GET http://0.0.0.0:9000/servicehealth/
    desc "Returns a basic status report."
    get "/" do
      MultiJson.dump({ status: 'OK', environment: Goliath::env })
    end      
  end

end