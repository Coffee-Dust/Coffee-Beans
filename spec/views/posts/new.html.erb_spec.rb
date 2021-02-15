require 'rails_helper'

RSpec.describe "posts/new.html.erb", type: :view do
  u = User.find_or_create_by(email:"yourface@idk.com") do |user|
     user.password = "yes"
     user.name = "Coffee Daddy"
  end
  post_content = "Your face is coffee idk"
  
  it "creates a new post only if valid" do
    user_login
    visit new_user_post_path(u)
    fill_in 'post[content]', with: post_content
    click_button('Post Bean')
    visit(user_post_path(u.id, u.posts.first.id))
    expect(u.posts.last.content).to eq(post_content)
  end

  it "will display error message if trying to submit invalid post" do
    user_login
    visit new_user_post_path(u)
    click_button('Post Bean')
    expect(page.find(".field_with_errors")).to be_truthy
  end
end
