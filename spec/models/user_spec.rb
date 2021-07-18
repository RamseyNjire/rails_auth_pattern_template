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

    it { should validate_uniqueness_of(:username) }

    it do
       should validate_presence_of(:password_digest).
       with_message("^Password cannot be blank")
    end

    it do
      should validate_length_of(:password)
      .is_at_least(6)
      .allow_nil
    end

    it { should validate_presence_of(:session_token) }
    
  end

  describe "#is_password?(password)" do
    before { user.save! }

    it "checks whether password matches user's original password" do
      expect(user.is_password?("Password")).to be true
    end
  end

  describe "::find_by_credentials(username, password)" do
    before { user.save! }
    context "with valid user credentials" do
      it "returns the correct user" do
        expect(User.find_by_credentials("Caligula", "Password")).to eq(user)
      end
    end

    context "with invalid user credentials" do
      it "returns nil" do
        expect(User.find_by_credentials("NotCaligula", "NotPassword")).not_to eq(user)
      end
    end
  end

  describe "#reset_session_token!" do
    before { user.save! }

    it "resets the user's session token" do
      old_session_token = user.session_token
      new_session_token = user.reset_session_token!

      expect(new_session_token).not_to eq(old_session_token)
    end
  end
end
