require 'rails_helper'

RSpec.describe UserNotification, type: :model do
  let(:user_notification) { UserNotification.new }
    it { expect(user_notification).to belong_to(:user)}
    it { expect(user_notification).to belong_to(:notification)}
end
