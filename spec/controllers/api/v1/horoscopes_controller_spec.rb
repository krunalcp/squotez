require "spec_helper"
require "rails_helper"
describe Api::V1::HoroscopesController , type: :controller do  
  it "response with horoscope" do
    horoscope = Intigration::HoroscopeInfo.get_horoscope_content("t")
    get(
      :horoscope,
      params: {d: "t".to_param}
    )
    data = JSON.parse(response.body)
    data == horoscope
  end
end
