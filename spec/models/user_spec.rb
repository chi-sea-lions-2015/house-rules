require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user) { User.new }
  it { expect(user).to validate_presence_of(:first_name).
            with_message("Must include first name") }
  it { expect(user).to validate_presence_of(:last_name).
            with_message("Must include last name") }
  it { expect(user).to validate_presence_of(:password).
            with_message("Must include password") }
  it { expect(user).to validate_presence_of(:email).
            with_message("Must include email") }
  it { expect(FactoryGirl.build(:user)).to validate_uniqueness_of(:email).with_message("Account for that email already exists")}
  it { expect(user).to validate_length_of(:password)}
  it { expect(user).to have_many(:housing_assignments) }
  it { expect(user).to have_many(:houses) }
  it { expect(user).to have_many(:chore_logs) }
  it { expect(user).to have_many(:chores) }
  it { expect(user).to have_many(:issues) }
  it { expect(user).to have_many(:user_promises) }
  it { expect(user).to have_many(:chores) }
end