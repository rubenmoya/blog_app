require "rails_helper"

RSpec.feature "Users signin" do
  before do
    @user = User.create!(email: "user@example.com", password: "password")
  end

  scenario "Sign in with valid credentials" do
    visit "/"

    click_link "Sign in"

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content(@user.email)
  end
end
