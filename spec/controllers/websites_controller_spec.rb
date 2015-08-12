require 'rails_helper'

RSpec.describe WebsitesController, type: :controller do

  describe "POST #create" do
    it "creates the website" do
      expect {
        post :create, website: { url: 'http://google.com' }
      }.to change { Website.count }.by 1
    end
  end

end
