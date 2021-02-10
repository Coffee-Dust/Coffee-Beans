require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  
  describe "GET #new" do
    it "will only load if user is logged in" do
      page.set_rack_session(session_id: "")
      visit(new_post_path)
      expect(current_path).to eq(login_path)
    end
  end

end
