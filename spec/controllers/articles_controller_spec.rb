require 'rails_helper'
require 'support/macros'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    before do
      @user1 = User.create(email: "user_one@example.com", password: "password")
      @user2 = User.create(email: "user_two@example.com", password: "password")
    end

    context "User IS the owner" do
      it "renders the edit template" do
        login_user @user1
        article = Article.create(title: "first article", body: "body of the first article", user: @user1)

        get :edit, id: article

        expect(response).to render_template :edit
      end
    end

    context "User IS NOT the owner" do
      it "should redirect to the root path" do
        login_user @user2
        article = Article.create(title: "first article", body: "body of the first article", user: @user1)

        get :edit, id: article

        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq("You can only edit your own articles.")
      end
    end

  end

end
