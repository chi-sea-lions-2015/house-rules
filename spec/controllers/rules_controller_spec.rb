require 'rails_helper'

RSpec.describe RulesController, type: :controller do
  describe "GET #index" do
    it "assigns all games as @games" do
      get :index, { id: game.to_param }
      expect(assigns(:games)).to eq([game])
    end
  end

end
