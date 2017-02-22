require 'rails_helper'

RSpec.describe Horoscope, type: :model do
  describe Horoscope do
    it "should have many other_details" do
      t = Horoscope.reflect_on_association(:other_details)
      t.macro.should == :has_many
    end
    it "is valid with the sign ,duration and horoscope_text" do
      horoscope = Horoscope.new(
        id: 1,
        sign: "arise",
        duration: "daily",
        horoscope_text: "2016 brings a host of exciting opportunities for every sign. Its five eclipses mark pivotal points that should be noted. The first is a Solar Eclipse that falls on March 8th in the sign of Pisces. This could be a time of spiritual renewal. It presents an ideal opportunity to go on a retreat or pilgrimage. Two weeks later, on March 23rd, a Lunar Eclipse will fall in collaborative Libra"
      )
      expect(horoscope).to be_valid
    end
    it "is invalid withouth sign" do
      horoscope = Horoscope.new(
        sign: nil
      )
      horoscope.valid?
      expect(horoscope.errors[:sign]).to include("can't be blank")
    end
    it "is invalid withouth duration" do
      horoscope = Horoscope.new(
        duration: nil
      )
      horoscope.valid?
      expect(horoscope.errors[:duration]).to include("can't be blank")
    end
    it "is invalid withouth horoscope_text" do
      horoscope = Horoscope.new(
        horoscope_text: nil
      )
      horoscope.valid?
      expect(horoscope.errors[:horoscope_text]).to include("can't be blank")
    end
  end
end
