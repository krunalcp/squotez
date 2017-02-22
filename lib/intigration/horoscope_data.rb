require 'nokogiri'
require 'open-uri'

module Intigration
  class HoroscopeData
    def self.create_horoscope_content
      @today = Date.today
      final_json = {}
      SIGNS_LIST.each do |slide_number, sign_name|
        theastrologer_url     = ENV['API_DOMAIN_2'] + sign_name.downcase.to_s if sign_name
        theastrologer_content = Nokogiri::HTML(
                                  open(
                                    theastrologer_url
                                  )
                                ).css("div#today")
        little_astro_content  = Nokogiri::HTML(
                                  open(
                                    ENV['API_DOMAIN_1']
                                  )
                                ).css("div#cbp-contentslider ul li#slide#{slide_number}")
        final_json["#{sign_name}"] =  self.process_horoscope_json(
                                        theastrologer_content,
                                        little_astro_content,
                                        slide_number, sign_name
                                      )
      end
    end

    def self.process_horoscope_json(theastrologer_content, little_astro_content, slide_number, sign_name)
      return {} if theastrologer_content.blank? and little_astro_content.blank? and slide_number.blank?

      horoscope = HoroscopeData.new(
                    theastrologer_content,
                    little_astro_content,
                    slide_number,
                    sign_name
                  )
      return horoscope.get_horoscope_json
    end

    def initialize(theastrologer_content, little_astro_content, slide_number, sign_name)
      @theastrologer_content = theastrologer_content
      @little_astro_content  = little_astro_content
      @slide_number          = slide_number
      @sign_name             = sign_name
    end

    def get_horoscope_json
      first_date_of_current_week  = Date.today.wday == 0 ? Date.today : Date.today.at_beginning_of_week - 1
      first_date_of_current_month = Date.today.at_beginning_of_month
      first_date_of_current_year  = Date.today.at_beginning_of_year
      horoscope_json = {}
      horoscope_json["daily"]     = create_daily_data
      horoscope_json["weekly"]    = create_weekly_data if Date.today == first_date_of_current_week
      horoscope_json["monthly"]   = create_monthly_data if Date.today == first_date_of_current_month
      horoscope_json["yearly"]    = create_yearly_data if Date.today == first_date_of_current_year
    end

    def create_daily_data
      data = {
              sign: @sign_name.to_s,
              duration: 'daily',
              horoscope_text: get_daily_horoscope,
            }
      @horoscope = Horoscope.new(data)
      @horoscope.save
      intensity = @theastrologer_content.css("div.row.daily-meta div[1] p[1]").text.split(':').last.gsub(' ', '').to_s
      keywords  = @theastrologer_content.css("div.row.daily-meta div[2] p[1]").text.split(':').last.gsub(' ', '')
      mood      = @theastrologer_content.css("div.row.daily-meta div[1] p[2]").text.split(':').last.gsub(' ', '')
      @horoscope.other_details.create(
        detail_type: "intensity",
        detail: intensity
      ) if @horoscope.save
      @horoscope.other_details.create(
        detail_type: "keywords",
        detail: keywords
      ) if @horoscope.save
      @horoscope.other_details.create(
        detail_type: "mood",
        detail: mood
      ) if @horoscope.save
    end

    def get_daily_horoscope
      daily_horoscope = ""
      daily_horoscope += @little_astro_content.css("div.cbp-content p").text
      daily_horoscope += " " + @theastrologer_content.css("p").first.text if @theastrologer_content.css("p").first

      return daily_horoscope
    end

    def create_weekly_data
      number = @slide_number.to_i + 1
      data_content =  Nokogiri::HTML(
                        open(
                          "#{ENV['API_DOMAIN_2']}#{ENV['API_DOMAIN_2_WEEKLY']}"
                        )
                      ).css("div.shareable-section-wrapper")
      return {} if data_content.blank?

      data = {
              sign: @sign_name.to_s,
              duration: "weekly",
              horoscope_text: data_content.css("div[#{number}]").text.split(' ')[1..-1].join(' ')
            } if data_content
      Horoscope.create(data) if data_content and data
    end

    def create_monthly_data
      number = @slide_number.to_i + 1
      monthly_data =  Nokogiri::HTML(
                        open(
                          "#{ENV['API_DOMAIN_2']}#{ENV['API_DOMAIN_2_MONTHLY']}"
                        )
                      ).css("div.shareable-section-wrapper").last

      data = {
              sign: @sign_name.to_s,
              duration: "monthly",
              horoscope_text: monthly_data.css("div[#{number}]").text.split(' ')[1..-1].join(' ')
            } if monthly_data
      Horoscope.create(data) if monthly_data and data
    end

    def create_yearly_data
      number = @slide_number.to_i + 1
      yearly_data = Nokogiri::HTML(
                      open(
                        "#{ENV['API_DOMAIN_2']}#{Time.now.year}-horoscope"
                      )
                    ).css("div.shareable-section-wrapper.shareable-yearly").last
      return {} if yearly_data.blank?
      inner_data = yearly_data.css("div[#{number}] p")
      final_data = ""
      inner_data.css("p").each do |para|
        final_data = final_data + para.text + "</br></br></t>"
      end

      data = {
              sign: @sign_name.to_s,
              duration: "yearly",
              horoscope_text: final_data
            } if final_data
      Horoscope.create(data) if final_data and data
    end

    def self.create_yearly_data_from_seed(slide_number, sign_name, data_date)
      number = slide_number.to_i + 1
      yearly_data = Nokogiri::HTML(
                      open(
                        "#{ENV['API_DOMAIN_2']}#{Time.now.year}-horoscope"
                      )
                    ).css("div.shareable-section-wrapper.shareable-yearly").last
      return {} if yearly_data.blank?
      inner_data = yearly_data.css("div[#{number}] p")
      final_data = ""
      inner_data.css("p").each do |para|
        final_data = final_data + para.text + "</br></br></t>"
      end

      data =  {
                sign: sign_name.to_s,
                duration: "yearly",
                horoscope_text: final_data,
                created_at: data_date
              } if final_data
      Horoscope.create(data) if final_data and data
    end

    def self.create_monthly_data_from_seed(
          slide_number,
          sign_name,
          data_date
        )
      number = slide_number.to_i + 1
      monthly_data =  Nokogiri::HTML(
                        open(
                          "#{ENV['API_DOMAIN_2']}#{ENV['API_DOMAIN_2_MONTHLY']}"
                        )
                      ).css("div.shareable-section-wrapper").last

      data = {
              sign: sign_name.to_s,
              duration: "monthly",
              horoscope_text: monthly_data.css("div[#{number}]").text.split(' ')[1..-1].join(' '),
              created_at: data_date
            } if monthly_data
      Horoscope.create(data) if monthly_data and data
    end

    def self.create_weekly_data_from_seed(slide_number, sign_name, data_date)
      number = slide_number.to_i + 1
      data_content =  Nokogiri::HTML(
                        open(
                          "#{ENV['API_DOMAIN_2']}#{ENV['API_DOMAIN_2_WEEKLY']}"
                        )
                      ).css("div.shareable-section-wrapper")
      return {} if data_content.blank?

      data = {
              sign: sign_name.to_s,
              duration: "weekly",
              horoscope_text: data_content.css("div[#{number}]").text.split(' ')[1..-1].join(' '),
              created_at: data_date
            } if data_content
      Horoscope.create(data) if data_content and data
    end
  end
end
