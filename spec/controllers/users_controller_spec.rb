require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:my_user) {create(:user, confirmed_at: Time.now)}

  before do
    sign_in my_user
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: my_user.id
      expect(response).to have_http_status(:success)
    end
  end

end
