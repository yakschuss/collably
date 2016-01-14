require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:event)  { create :event }
  let(:user) {create(:user, confirmed_at: Time.now)}

end
