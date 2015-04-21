require 'rails_helper'

RSpec.describe Message, type: :model do
  message = FactoryGirl.build(:message)
  it { expect(message).to validate_length_of(:content).is_at_least(2)}
  it { expect(message).to belong_to(:author)}
  it { expect(message).to belong_to(:house)}
end
