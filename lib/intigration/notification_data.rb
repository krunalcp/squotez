module Intigration
  class NotificationData
    #
    # return notification and category from start data to end data
    #
    def self.get_notification_content(
          start_date,
          end_date
        )
      data = {
        categories: [],
        notifications: []
      }
      if start_date and end_date
        return {} if start_date.split('-').count !=3 or end_date.split('-').count != 3
        date_condition = "date(created_at) between ? and ?", start_date, end_date
        categories = Category.where(date_condition)
        categories.each do |category|
          data[:categories] << self.get_category_data(category)
        end
        notifications = Notification.where(date_condition)
        notifications.each do |notification|
          data[:notifications] << self.get_notification_data(notification)
        end
        return data
      end
    end

    def self.get_category_data(category)
      return {
        id:   category.id,
        name: category.name,
        type: category.type
      }
    end

    def self.get_notification_data(notification)
      data_hash = {}
      data_hash = {
                    notification_text: notification.notification_text, 
                    type: notification.type, 
                    categories: notification.categories.pluck(&:id),
                    author: notification.author
                  }
      return data_hash.delete_if { |key, value| value.blank? }
    end
  end
end