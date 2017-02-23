class Api::V1::InfosController < Api::ApiController
  def info
    info =  Intigration::NotificationData.get_notification_content(
              params[:start_date],
              params[:end_date]
            )
    render json: info
  end
end
