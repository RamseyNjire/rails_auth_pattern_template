require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user){ build(:user) }

  describe "validations" do
    it { should validate_presence_of(:username)}
  end
end
