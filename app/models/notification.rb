class Notification < ApplicationRecord
  self.inheritance_column = :_type_disabled

  #
  # Associations
  #
  has_many(
    :notification_categories,
    dependent: :delete_all
  )
  has_many(
    :categories,
    through: :notification_categories
  )
  accepts_nested_attributes_for(
    :categories,
    allow_destroy: true
  )
  #
  # Validations
  #
  validates(
    :notification_text,
    presence: true
  )
  validates(
    :type,
    presence: true
  )
end
