require 'rails_helper'

RSpec.describe PostsController, type: :feature do

  describe "GET #new" do
    it "will only load if user is logged in" do
      page.set_rack_session(session_id: "")
      visit(new_post_path)
      expect(current_path).to eq(login_path)
    end
  end

  describe "GET #edit" do
    it "will only load if current user is the owner of the post" do
      u = User.create(name: "a", email: "asdas", password:"yes")
      user_login
      find_test_user(page)
      p = Post.create!(content: "jsdjfksdjfi", user: u)
      visit edit_post_path(p)
      expect(current_path).to eq(user_path(@test_user))
    end

    it "will update a post when submitted" do
      user_login
      find_test_user(page)
      p = Post.create!(content: "jsdjfksdjfi", user: @test_user)
      visit edit_post_path(p)
      fill_in "post[content]", with: "Your face"
      click_button("Update Bean")
      
      expect(Post.find(p.id).content).to eq("Your face")
    end
  end

  describe "POST #update" do
    it "will redirect you to the updated post" do
      user_login
      find_test_user(page)
      p = Post.create!(content: "jsdjfksdjfi", user: @test_user)
      visit edit_post_path(p)
      fill_in "post[content]", with: "Your face"
      click_button("Update Bean")

      expect(current_path).to eq(user_post_path(@test_user, p))
    end
  end

  describe "POST #destroy" do
    it "will delete that post" do
      user_login
      find_test_user(page)
      p = Post.create!(content: "jsdjfksdjfi", user: @test_user)
      visit user_post_path(@test_user, p)

      click_button("Delete Bean")

      expect(Post.find_by(id: p.id)).to eq(nil)
    end
  end

end
