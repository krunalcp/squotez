require "spec_helper"
require "rails_helper"
describe Api::V1::InfosController , type: :controller do  
  it "response with information" do
    info = Intigration::NotificationData.get_notification_content("2017-02-19","2017-02-20")
    get(
      :info,
      params: {
        start_date: "2017-02-19".to_param,
        end_date: "2017-02-20".to_param
      }
    )
    data = JSON.parse(response.body)
    data == info
  end
end
