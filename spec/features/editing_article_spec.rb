require "rails_helper"

RSpec.feature "Editing an article" do
  before do
    @user = User.create(email: "user@example.com", password: "password")
    login_as(@user)
    @article = Article.create(title: "First article", body: "Body of first article", user: @user)
  end

  scenario "A user updates an article" do
    visit "/"

    click_link @article.title
    click_link "Edit"

    fill_in "Title", with: "Updated title of the article"
    fill_in "Body", with: "Updated body of the article"

    click_button "Submit"

    expect(page).to have_content("Article has been updated")
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario "A user fails to update an article" do
    visit "/"

    click_link @article.title
    click_link "Edit"

    fill_in "Title", with: ""
    fill_in "Body", with: ""

    click_button "Submit"

    expect(page).to have_content("Article has not been updated")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end
