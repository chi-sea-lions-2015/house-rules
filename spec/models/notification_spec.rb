require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:notification) { Notification.new }
    it { expect(notification).to have_many(:users)}
    it { expect(notification).to have_many(:user_notifications)}
end
