require 'rails_helper'

RSpec.describe Category, type: :model do
  describe Category do
    it "should have many notification_categories" do
      t = Category.reflect_on_association(:notification_categories)
      t.macro.should == :has_many
    end
    it "should have many notifications" do
      t = Category.reflect_on_association(:notifications)
      t.macro.should == :has_many
    end
    context "when saved" do
      subject {
        Category.create(
          id: 1,
          name: "Science",
          type: "Quotes"
        )
      }
      it { should_not be_a_new(Category) }
    end
  end
end