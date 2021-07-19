require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    subject(:user){ build(:user) }
    
    describe "GET #new" do
        context "when not logged in" do
            it "renders the new template" do
                get :new, params: {}
                expect(response).to render_template(:new)
            end
        end

        context "when logged in" do
            before { user.save! }
            it "redirects to the user show page" do
                post :create, params: { user: {
                                                username: "Caligula",
                                                password: "Password"
                } }

                get :new, params: {}
                expect(response).to redirect_to(user_url(user))
            end
        end
    end

    describe "POST #create" do
        before { user.save! }
        context "with valid params" do
            it "logs in the user and redirects to the user show page" do
                post :create, params: { user: {
                                                username: "Caligula",
                                                password: "Password"
                } }

                expect(session[:session_token]).to eq(user.session_token)
                expect(response).to redirect_to(user_url(user))
                expect(assigns(:current_user)).to eq(user)
            end
        end

        context "with invalid params" do
            it "validates the params" do
                post :create, params: { user: {
                                                username: "NotCaligula",
                                                password: "NotPassword"
                } }

                expect(response).to render_template(:new)
                expect(flash[:errors]).to be_present
            end
        end
    end

    describe "DELETE #destroy" do
        before do
            user.save!

            post :create, params: { user: {
                                            username: "Caligula",
                                            password: "Password"
            } }
        end

        it "logs out the user" do
            expect(assigns(:current_user)).to receive(:reset_session_token!)

            delete :destroy, params: {}


            expect(response).to redirect_to(new_session_url)
            expect(session[:session_token]).to be_nil
        end
    end
end
