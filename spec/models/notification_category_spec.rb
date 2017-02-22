require 'rails_helper'

RSpec.describe NotificationCategory, type: :model do
  describe NotificationCategory do
    it "belongs_to to notification" do
      NotificationCategory.reflect_on_association(:notification).macro.should  eq(:belongs_to)
    end
    it "belongs_to to category" do
      NotificationCategory.reflect_on_association(:category).macro.should eq(:belongs_to)
    end
  end
end
