require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user){ build(:user) }

  describe "validations" do
    it { should validate_presence_of(:username) }

    it do
       should validate_presence_of(:password_digest).
       with_message("^Password cannot be blank")
    end

    it { should validate_length_of(:password).allow_nil }
    
  end
end
