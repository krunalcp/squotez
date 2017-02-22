class Category < ApplicationRecord
  self.inheritance_column = :_type_disabled

  #
  # Associations
  #
  has_many(
    :notification_categories,
    dependent: :delete_all
  )
  has_many(
    :notifications,
    through: :notification_categories
  )

  #
  # validations
  #
  validates(
    :name,
    presence: true
  )
  validates(
    :type,
    presence: true
  )
end
