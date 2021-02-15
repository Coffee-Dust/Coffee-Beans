require 'rails_helper'

RSpec.describe CommentsController, type: :feature do
  describe "POST CREATE" do
    u = User.create!({name: "John", email: SecureRandom.hex, password: "yourface"})
    p = Post.create!(content: "lol idk why you ask?", user: u)
    it "should create a new comment" do
      user_login
      find_test_user(page)
      visit user_post_path(p.user, p)
      fill_in("comment[content]", with: "Haha cause your a face")
      click_button("submit")

      expect(p.comments.count).to eq(1)
    end

    it "should redirect back to the post" do
      user_login
      find_test_user(page)
      visit user_post_path(p.user, p)
      fill_in("comment[content]", with: "Haha cause your a face")
      click_button("submit")

      expect(current_path).to eq(user_post_path(p.user, p))
    end
  end

  describe "DELETE DESTROY" do
    u = User.create!({name: "John", email: SecureRandom.hex, password: "yourface"})
    p = Post.create!(content: "lol idk why you ask?", user: u)
    it "should delete a comment" do
      user_login
      find_test_user(page)
      c = Comment.create!(content: "I dare you to delete me!", user_id: @test_user.id, post: p)
      visit user_post_path(p.user, p.id)
      raise "comment didn't create" if p.comments.count == 0

      click_button("Delete")
      expect(p.comments.count).to eq(0)
    end
    it "should delete a comment only if CURRENT_USER is the owner" do
      p2 = Post.create!(content: "lol idk why you ask?", user: u)
      user_login
      find_test_user(page)
      c = Comment.create!(content: "I dare you to delete me!", user_id: u.id, post: p2)
      visit user_post_path(p2.user, p2.id)
      raise "comment didn't create" if p2.comments.count == 0
      expect(page).to_not have_css(".delete_comment")
    end
  end
end
