class Horoscope < ApplicationRecord

  #
  # Associations
  #
  has_many(
    :other_details,
    as: :detailable,
    dependent: :delete_all
  )
  accepts_nested_attributes_for(
    :other_details,
    allow_destroy: true
  )

  #
  # Validations
  #
  validates(
    :sign,
    presence: true
  )
  validates(
    :duration,
    presence: true
  )
  validates(
    :horoscope_text,
    presence: true
  )
end
