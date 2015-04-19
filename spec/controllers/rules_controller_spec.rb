require 'rails_helper'

RSpec.describe RulesController, type: :controller do

  describe 'Rules' do
    let(:house){House.create!(name: "My house", house_key: "myhouse")}
    let(:rule){ House.rules.create!(content: "Shower daily")}

    it "includes content" do
      get "/houses/#{house.id}/rules"
      expect(last_response.body).to have_json_path("content")
    end

    it "has a status code of 200" do
      get "/houses/#{house.id}/rules"
      expect(response).to be_success
    end

  end

end
