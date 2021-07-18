require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    subject(:user){ build(:user) }
    describe "GET #new" do
        it "renders the new template" do
            get :new, params: {}
            expect(response).to render_template(:new)
        end
    end
end
