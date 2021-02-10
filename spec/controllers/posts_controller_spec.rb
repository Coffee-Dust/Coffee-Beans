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
  end

end
