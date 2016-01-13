require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}
  it { should have_many (:posts)}

end
