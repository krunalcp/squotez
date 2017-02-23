class User < ApplicationRecord
  #
  # Validations
  #
  validates(
    :email,
    presence: true,
    uniqueness: true,
    format: {
      with: EMAIL_REGEX
    },
    length: {
      in: 5..255
    }
  )
end
