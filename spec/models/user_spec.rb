# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
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

  describe "#is_password?(password)" do
    before { user.save! }

    it "checks whether password matches user's original password" do
      expect(user.is_password?("Password")).to be true
    end
  end
end
