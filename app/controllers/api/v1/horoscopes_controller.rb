class Api::V1::HoroscopesController < Api::ApiController
  def horoscope
    horoscope = Intigration::HoroscopeInfo.get_horoscope_content(params[:d])
    render json: horoscope
  end
end
