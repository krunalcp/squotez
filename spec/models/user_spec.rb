require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    it "is valid with the email name" do
      user = User.new(
        id: 1,
        email: "email@softices.com",
        first_name: "email"
      )
      expect(user).to be_valid
    end
    it "is invalid withouth email" do
      user = User.new(
        email: "email.com"
      )
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
    it "is invalid withouth email" do
      user = User.new(
        email: nil
      )
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
  end
end
