require 'rails_helper'

def liker_helper(u, p, page)
  user_login
  find_test_user(page)

  visit(user_post_path(u, p))
  click_button('like')
end

RSpec.describe ReactionsController, type: :feature do

  describe "POST #create" do
    it "creates a new reaction with a user and post" do
      @u = User.create!(password: "e", email: SecureRandom.hex, name: "e")
      @p = Post.create!(content: "e", user: @u)
      liker_helper(@u, @p, page)
      expect(@p.reactions.last.reaction_type).to eq(1)
    end

    it "redirects to the reactions Post after submitted" do
      @u = User.create!(password: "e", email: SecureRandom.hex, name: "e")
      @p = Post.create!(content: "e", user: @u)
      liker_helper(@u, @p, page)
      expect(current_path).to eq(user_post_path(@p.user, @p))
    end
  end

  describe "DELETE #destroy" do
    it "deletes the reaction" do
      Reaction.destroy_all
      @u = User.create!(password: "e", email: SecureRandom.hex, name: "e")
      @p = Post.create!(content: "e", user: @u)
      liker_helper(@u, @p, page)
      liker_helper(@u, @p, page)
      expect(@p.reactions.count).to eq(0)
    end
  end

  describe "Model specs(fight me i know im on the controller" do
    it "can find the reaction with user and reactable" do
      u = User.create!(password: "e", email: SecureRandom.hex, name: "e")
      p = Post.create!(content: "e", user: u)
      r = Reaction.create!(reactable: p, user: u, reaction_type: 1)

      expect(Reaction.find_reactions_for_user_on_reactable(u, p).first.id).to eq(r.id)
    end
  end
end
