require "rails_helper"

RSpec.feature "Showing an article" do
  before do
    @user = User.create(email: "user@example.com", password: "password")
    login_as(@user)
    @article = Article.create(title: "The first article", body: "Body of first article", user: @user)
  end

  scenario "Display individual article" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)

    expect(current_path).to eq(article_path(@article))
  end
end
