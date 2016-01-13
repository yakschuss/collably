require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user, confirmed_at: Time.now)}
  let(:event) {create(:event)}

  it {should have_many(:events)}

#  before do
#    sign_in user
#  end






end
