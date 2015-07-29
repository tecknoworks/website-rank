require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)

      #example to create user using factory_girl 
      user = create(:user)
      user = create(:user, email: 'test@test.com')

    end
  end

end
