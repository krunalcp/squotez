class Api::V1::HoroscopeDatasController < Api::ApiController
  def parser_horoscope
    Intigration::HoroscopeData.create_horoscope_content
  end
end
