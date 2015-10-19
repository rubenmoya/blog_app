require "rails_helper"

RSpec.feature "Adding reviews to articles" do
  before do
    @user1 = User.create(email: "user_one@example.com", password: "password")
    @user2 = User.create(email: "user_two@example.com", password: "password")

    @article = Article.create(title: "First article", body: "Body of first article", user: @user1)
  end

  context "User IS logged in" do
    it "can review an article" do
      login_as @user1

      visit "/"

      click_link @article.title

      fill_in "New comment", with: "Awesome article!"

      click_button "Add comment"

      expect(page).to have_content("Comment has been created.")
      expect(page).to have_content("Awesome article!")
      expect(current_path).to eq(article_path(@article.comments.last.id))
    end
  end
end
