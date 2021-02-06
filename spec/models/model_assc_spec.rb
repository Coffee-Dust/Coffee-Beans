require 'rails_helper'

describe User do
  user_attr = {name: "John", email: "your@face.com", password: "yourface"}
  it "creates new User with attributes" do
    expect(User.new(user_attr)).to be_valid
  end

  it "has many posts" do
    u = User.create(user_attr)
    p = u.posts.create(content: "Lol you get banned?")
    expect(u.posts.count).to be_equal(1)
  end
  it "has the post foreign key assigned" do
    u = User.create(user_attr)
    p = u.posts.create(content: "Lol you get banned?")
    expect(p.user_id).to be_equal(u.id)
  end

  it "has many comments" do
    u = User.create(user_attr)
    p = u.posts.create(content: "Lol you get banned?")
    c = p.comments.create(content: "i replied to my own post, am lonely", user: u)
    expect(u.comments.first.id).to be_equal(c.id)
  end

  it "has many commentented posts through comments" do
    u = User.create(user_attr)
    p = u.posts.create(content: "Lol you get banned?")
    c = p.comments.create(content: "i replied to my own post, am lonely", user: u)
    expect(u.commented_posts.first.id).to be_equal(p.id)
  end
end

describe Post do
  u = User.create({name: "John", email: "your@face.com", password: "yourface"})
  p = u.posts.create(content: "Lol idk")
  c1 = p.comments.create(content: "idk", user: u)

  it "has many comments" do
    expect(p.comments.count).to be_equal(1)
  end

  it "has many users through comments(users_who_commented)" do
    expect(p.users_who_commented).to include(u)
  end

end