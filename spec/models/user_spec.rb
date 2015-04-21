require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user) { User.new }
  it { expect(user).to validate_presence_of(:first_name) }
  it { expect(user).to validate_presence_of(:last_name)}
  it { expect(user).to validate_presence_of(:email)}
  it { expect(user).to validate_uniqueness_of(:email)}
  it { expect(user).to allow_value("me@me.com", "you@gmail.com").for(:email)}
  it { expect(user).to validate_presence_of(:password)}
  it { expect(user).to validate_length_of(:password).is_at_least(6)}
  it { expect(user).to have_many(:messages) }
  it { expect(user).to have_many(:housing_assignments) }
  it { expect(user).to have_many(:houses) }
  it { expect(user).to have_many(:events) }
  it { expect(user).to have_many(:chore_logs) }
  it { expect(user).to have_many(:chores) }
  it { expect(user).to have_many(:issues) }
  it { expect(user).to have_many(:user_promises) }

end
