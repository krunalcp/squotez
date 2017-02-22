require "spec_helper"
require "rails_helper"
describe Api::V1::UserDatasController , type: :controller do  
  it "create a user" do
    post(
      :create,
      params: {
        email: "email@softices.com",
        first_name: "email"
      }
    )
    response.status == 201
  end
end