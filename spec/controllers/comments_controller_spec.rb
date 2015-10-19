require 'rails_helper'
require 'support/macros'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    before do
      @user = User.create(email: "user@example.com", password: "password")
      @article = Article.create(title: "First article", body: "Body of the first article", user: @user)
    end

    context "user IS signed in" do
      it "can create a comment" do
        login_user @user

        post :create, comment: { body: "Awesome article!" }, article_id: @article.id

        expect(flash[:success]).to eq("Comment has been created.")
      end
    end

    context "user IS NOT signed in" do
      it "is redirected to sign in page" do
        login_user nil

        post :create, comment: { body: "Awesome article!" }, article_id: @article.id

        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
