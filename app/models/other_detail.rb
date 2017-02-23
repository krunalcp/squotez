class OtherDetail < ApplicationRecord
  #
  # Associations
  #
  belongs_to(
    :detailable,
    polymorphic: true
  )

  #
  # Validations
  #
  validates(
    :detailable_id,
    presence: true
  )
  validates(
    :detailable_type,
    presence: true
  )
end
