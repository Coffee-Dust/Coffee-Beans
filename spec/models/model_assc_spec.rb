require 'rails_helper'

describe User do
  user_attr = {name: "John", password: "yourface"}
  it "creates new User with attributes" do
    expect(User.new({name: "John", email: SecureRandom.hex, password: "yourface"})).to be_valid
  end

  it "has many posts" do
    u = User.create({name: "John", email: SecureRandom.hex, password: "yourface"})
    p = u.posts.create(content: "Lol you get banned?")
    expect(u.posts.count).to be_equal(1)
  end
  it "has the post foreign key assigned" do
    u = User.create({name: "John", email: SecureRandom.hex, password: "yourface"})
    p = u.posts.create(content: "Lol you get banned?")
    expect(p.user_id).to be_equal(u.id)
  end

  it "has many comments" do
    u = User.create({name: "John", email: SecureRandom.hex, password: "yourface"})
    p = u.posts.create(content: "Lol you get banned?")
    c = p.comments.create(content: "i replied to my own post, am lonely", user: u)
    expect(u.comments.first.id).to be_equal(c.id)
  end

  it "has many commentented posts through comments" do
    u = User.create({name: "John", email: SecureRandom.hex, password: "yourface"})
    p = u.posts.create(content: "Lol you get banned?")
    c = p.comments.create(content: "i replied to my own post, am lonely", user: u)
    expect(u.commented_posts.first.id).to be_equal(p.id)
  end

  it "has a secure password" do
    u = User.create({name: "John", email: SecureRandom.hex, password: "yourface"})
    expect(u.password_digest).to_not be_equal("yourface")
  end

  it "has a secure password with #authenticate" do
    u = User.create({name: "John", email: SecureRandom.hex, password: "yourface"})
    expect(u.authenticate(user_attr[:password])).to be_truthy
    expect(u.authenticate("passwordalllowercase")).to be(false)
  end
end

describe Post do
  u = User.create({name: "John", email: SecureRandom.hex, password: "yourface"})
  p = u.posts.create(content: "Lol idk")
  c1 = p.comments.create(content: "idk", user: u)

  it "has many comments" do
    expect(p.comments.count).to be_equal(1)
  end

  it "has many users through comments(users_who_commented)" do
    expect(p.users_who_commented).to include(u)
  end

  it "has many reactions" do
    p.reactions.create(reaction_type: 1, user: u)
    expect(p.reactions.count).to be_equal(1)
  end

end

describe Comment do
  u = User.create({name: "John", email: SecureRandom.hex, password: "yourface"})
  p = u.posts.create(content: "Lol idk")
  c1 = p.comments.create(content: "idk", user: u)
  it "has many reactions" do
    c1.reactions.create(reaction_type: 1, user: u)
    expect(c1.reactions.count).to be_equal(1)
  end

  it "is valid only if it has a user, post and content" do
    c2 = Comment.new(content: "")
    expect(c2.valid?).to eq(false)
  end
end