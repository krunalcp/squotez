require 'rails_helper'

RSpec.describe OtherDetail, type: :model do
  describe OtherDetail do
    it "belongs_to to oher_detail" do
      OtherDetail.reflect_on_association(:detailable).macro.should  eq(:belongs_to)
    end
    it "is invalid withouth detailable_id" do
      oher_detail = OtherDetail.new(
        detailable_id: nil
      )
      oher_detail.valid?
      expect(oher_detail.errors[:detailable_id]).to include("can't be blank")
    end
    it "is invalid withouth detailable_type" do
      oher_detail = OtherDetail.new(
        detailable_type: nil
      )
      oher_detail.valid?
      expect(oher_detail.errors[:detailable_type]).to include("can't be blank")
    end
  end
end
