require 'spec_helper'

describe Falconhoof::API do

  def app
    @app ||= Falconhoof::API
  end

  describe "GET '/'" do
    it "should be successful" do
      get '/'
      last_response.should be_ok
    end
  end
end
