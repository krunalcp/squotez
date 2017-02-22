require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe Notification do
    it "should have many notification_categories" do
      t = Notification.reflect_on_association(:notification_categories)
      t.macro.should == :has_many
    end
    it "should have many categories" do
      t = Notification.reflect_on_association(:categories)
      t.macro.should == :has_many
    end
    context "when saved" do
      subject {
        Notification.create(
          id: 1,
          notification_text: "Science",
          type: "Quotes",
          language: "Eng"
        )
      }
      it { should_not be_a_new(Notification) }
    end
  end
end
