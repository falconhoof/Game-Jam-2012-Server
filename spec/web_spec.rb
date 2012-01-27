require 'spec_helper'

describe Falfonhoof::Web do

  def app
    @app ||= Falconhood::Web
  end

  describe "GET '/'" do
    it "should be successful" do
      get '/'
      last_response.should be_ok
    end
  end
end
