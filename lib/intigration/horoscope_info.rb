require 'nokogiri'
require 'open-uri'
module Intigration
  class HoroscopeInfo
    #
    # Return Horoscope of Daily, Weekly, Monthly and Yearly
    # 
    def self.get_horoscope_content(duration)
      first_date_of_current_week  = Date.today.wday == 0 ? Date.today : Date.today.at_beginning_of_week - 1
      first_date_of_current_month = Date.today.at_beginning_of_month
      first_date_of_current_year  = Date.today.at_beginning_of_year
      final_json = {}
      SIGNS_LIST.each do |sign_id, sign_name|
        final_json[sign_name] = []

        #
        # Daily horoscope for sign
        #
        daily_horoscope = Horoscope.where(
                            sign: sign_name.to_s,
                            duration: "daily",
                            created_at: Date.today
                          ) if duration.downcase.include?('t')
        final_json[sign_name] <<  {
                                    daily:  get_daily_data(
                                              daily_horoscope.first,
                                              sign_name
                                            )
                                  } if duration.downcase.include?('t') and daily_horoscope

        #
        # Weekly horoscope for sign
        #
        weekly_horoscope =  Horoscope.where(
                              sign: sign_name.to_s,
                              duration: "weekly",
                              created_at: first_date_of_current_week
                            ) if duration.downcase.include?('w')
        final_json[sign_name] <<  {
                                    weekly: get_horoscope_data(weekly_horoscope.first)
                                  } if duration.downcase.include?('w') and weekly_horoscope

        #
        # Monthly horoscope for sign
        #
        monthly_horoscope = Horoscope.where(
                              sign: sign_name.to_s,
                              duration: "monthly",
                              created_at: first_date_of_current_month
                            ) if duration.downcase.include?('m')
        final_json[sign_name] <<  {
                                    monthly: get_horoscope_data(monthly_horoscope.first)
                                  } if duration.downcase.include?('m') and monthly_horoscope

        #
        # Yearly horoscope for sign
        #
        yearly_horoscope =  Horoscope.where(
                              sign: sign_name.to_s,
                              duration: "yearly",
                              created_at: first_date_of_current_year
                            ) if duration.downcase.include?('y')
        final_json[sign_name] <<  {
                                    yearly: get_horoscope_data(yearly_horoscope.first)
                                  } if duration.downcase.include?('y') and yearly_horoscope
      end

      return final_json
    end

    #
    # Return date and horoscope
    #
    def self.get_daily_data(
          daily_horoscope,
          sign_name
        )
      data = {}
      unless daily_horoscope.blank?
        data =  {
                  date: daily_horoscope.created_at,
                  horoscope: daily_horoscope.horoscope_text.to_s
                }.merge(
                  get_other_details(daily_horoscope)
                )
      end
      return data
    end

    #
    # Return horoscpe text
    #
    def self.get_horoscope_data(horoscope_data)
      return { horoscope: horoscope_data.horoscope_text.to_s } if horoscope_data
    end

    #
    # Return Horoscope othre details
    #
    def self.get_other_details(horoscope_data)
      data = {}
      horoscope_data.other_details.each do |other_detail|
        data[other_detail.detail_type] = other_detail.detail
      end
      return data
    end
  end
end