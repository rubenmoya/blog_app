require "rails_helper"

RSpec.feature "Showing an article" do
  before do
    @user1 = User.create(email: "user_one@example.com", password: "password")
    @user2 = User.create(email: "user_two@example.com", password: "password")
    @article = Article.create(title: "The first article", body: "Body of first article", user: @user1)
  end

  scenario "Display individual article" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)

    expect(current_path).to eq(article_path(@article))
  end

  context "User IS loged in" do

    it "Can edit/delete his article" do
      login_as(@user1)

      visit "/"

      click_link @article.title

      expect(page).to have_link("Edit")
      expect(page).to have_link("Delete")
    end

    it "Can't edit/delete other user article" do
      login_as(@user2)

      visit "/"

      click_link @article.title

      expect(page).not_to have_link("Edit")
      expect(page).not_to have_link("Delete")
    end

  end

  context "user IS NOT loged in" do
    it "Can't edit/delete articles" do
      visit "/"

      click_link @article.title

      expect(page).not_to have_link("Edit")
      expect(page).not_to have_link("Delete")
    end
  end
end
