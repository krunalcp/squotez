class NotificationCategory < ApplicationRecord

  #
  # Associations
  #
  belongs_to     :notification
  belongs_to     :category
end
