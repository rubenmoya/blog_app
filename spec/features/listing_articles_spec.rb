require "rails_helper"

RSpec.feature "Listing Articles" do
  before do
    @user = User.create(email: "user@example.com", password: "password")
    login_as(@user)
    @article1 = Article.create(title: "The first article", body: "Body of first article", user: @user)
    @article2 = Article.create(title: "The second article", body: "Body of second article", user: @user)
  end

  scenario "List all articles" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)

    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)

    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)

    expect(page).not_to have_link("New article")
  end
end
