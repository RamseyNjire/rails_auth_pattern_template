require 'rails_helper'

feature "the signup process" do

    scenario 'has a new user page' do
        visit new_user_url
        expect(page).to have_content 'Create Account'
    end

    feature "signing up a user" do
        before do
            visit new_user_url
            fill_in "Username:", with: "Augustus"
            fill_in "Password:", with: "Password"

            click_on "Create Account"
        end

        scenario "redirects to user show page after signup" do
            expect(page).to have_content "Augustus"
        end

        scenario "logout button is visible" do
            expect(page).to have_button("Logout")
        end
    end

    feature "signing in a user" do
        subject(:user) { create(:user) }
        before do
            visit new_session_url
            fill_in "Username:", with: user.username
            fill_in "Password:", with: user.password

            click_on "Login"
        end

        scenario "redirects to user show page after signup" do
            expect(page).to have_content "Caligula"
        end

        scenario "logout button is visible" do
            expect(page).to have_button("Logout")
        end
    end

end