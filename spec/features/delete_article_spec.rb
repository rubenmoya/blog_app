require "rails_helper"

RSpec.feature "Deleting an article" do
  before do
    @user = User.create(email: "user@example.com", password: "password")
    login_as(@user)
    @article = Article.create(title: "First article", body: "Body of first article", user: @user)
  end

  scenario "A user deletes an article" do
    visit "/"

    click_link @article.title
    click_link "Delete"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end
