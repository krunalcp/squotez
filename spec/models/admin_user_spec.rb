require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe AdminUser do
    context "when saved" do
      subject {
        AdminUser.create(
          email: 'admin@example.com',
          password: 'password',
          password_confirmation: 'password'
        )
      }
      it { should_not be_a_new(AdminUser) }
    end
  end
end
